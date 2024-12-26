//
//  HomeViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine
import MapKit

class HomeViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var drivers = [User]()
    @Published var trip: Trip?
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    var currentUser: User?
    var routeToPickUpLocation: MKRoute?
    
    // Location Search Properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedDriveNowLocation: DriveNowLocation?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    private let searchCompleter = MKLocalSearchCompleter()
    var userLocation: CLLocationCoordinate2D?
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: - Lifecycle
    
    override init () {
        super.init()
        fetchUser()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: - USER API
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else { return }
                
                if user.accountType == .passenger {
                    self.fetchDrivers()
                    self.addTripObserverForPassenger()
                } else {
                    self.addTripObserverForDriver()
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateTripState(state: TripState) {
        guard let trip = trip else { return }
        
        var data = ["state" : state.rawValue]
        
        if state == .accepted {
            data["travelTimeToPassenger"] = trip.travelTimeToPassenger
        }
        
        Firestore.firestore().collection("trips").document(trip.id).updateData(data) { _ in
            print("DEBUG: Did update trip with state \(state)")
        }
    }
    
}

// MARK: - Passenger API

extension HomeViewModel {
    
    func addTripObserverForPassenger() {
        guard let currentUser = currentUser, currentUser.accountType == .passenger else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("passengerUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first,
                      change.type == .added || change.type == .modified else { return }
                
                guard let trip = try? change.document.data(as: Trip.self) else { return }
                self.trip = trip
                print("DEBUG: Updated trip state is \(trip.state)")
        }
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users").whereField("accountType", isEqualTo: AccountType.driver.rawValue).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let drivers = documents.compactMap({ try? $0.data(as: User.self) })
            self.drivers = drivers
//            print("DEBUG: Drivers \(drivers)")
        }
    }
    
    func requestTrip() {
        print("DEBUG: Requesting trip")
        guard let driver = drivers.first else { return }
        guard let currentUser = currentUser else { return }
        guard let dropOffLocation = selectedDriveNowLocation else { return }
        let dropOffGeoPoint = GeoPoint(latitude: dropOffLocation.coordinate.latitude, longitude: dropOffLocation.coordinate.longitude)
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        
        getPlacemark(forLocation: userLocation) { placemark, error in
            guard let placemark = placemark else { return }
            
            let tripCost = self.computeRidePrice(forType: .cabX)
            
            let trip = Trip(
                passengerUid: currentUser.uid,
                driverUid: driver.uid,
                passengerName: currentUser.fullName,
                driverName: driver.fullName,
                passengerLocation: currentUser.coordinates,
                driverLocation: driver.coordinates,
                pickUpLocationName: placemark.name ?? "Current Location",
                dropOffLocationName: dropOffLocation.title,
                pickUpLocationAddress: self.addressFromPlacemark(placemark),
                pickUpLocation: currentUser.coordinates,
                dropOffLocation: dropOffGeoPoint,
                tripCost: tripCost,
                distanceToPassenger: 0,
                travelTimeToPassenger: 0,
                state: .requested
            )
            print("DEBUG: Requesting trip: \(trip)")
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            Firestore.firestore().collection("trips").document().setData(encodedTrip) { _ in
                print("DEBUG: Trip request upload was successfull")
            }
        }
    }
    
    func cancelTripAsPassenger() {
        updateTripState(state: .passengerCanelled)
    }
}

// MARK: - Driver API

extension HomeViewModel {
    
    func addTripObserverForDriver() {
        guard let currentUser = currentUser, currentUser.accountType == .driver else { return }
        
        Firestore.firestore().collection("trips")
            .whereField("driverUid", isEqualTo: currentUser.uid)
            .addSnapshotListener { snapshot, _ in
                guard let change = snapshot?.documentChanges.first,
                      change.type == .added || change.type == .modified else { return }
                
                guard let trip = try? change.document.data(as: Trip.self) else { return }
                self.trip = trip
                print("DEBUG: Fetched trip for driver: \(trip)")
                
                self.getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickUpLocation.toCoordinate()) { route in
                    print("DEBUG: Expected travel time to passenger: \(Int(route.expectedTravelTime / 60))")
                    print("DEBUG: Distance from passenger to driver: \(route.distance.distanceInMilesString())")
                    self.routeToPickUpLocation = route
                    self.trip?.travelTimeToPassenger = Int(route.expectedTravelTime / 60)
                    self.trip?.distanceToPassenger = route.distance
                }
        }
    }
    
//    func fetchTrips() {
//        guard let currentUser = currentUser else { return }
//        
//        Firestore.firestore().collection("trips").whereField("driverUid", isEqualTo: currentUser.uid).getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents, let document = documents.first else { return }
//            guard let trip = try? document.data(as: Trip.self) else { return }
//            
//            self.trip = trip
//            print("DEBUG: Fetched trip for driver: \(trip)")
//            
//            self.getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickUpLocation.toCoordinate()) { route in
//                print("DEBUG: Expected travel time to passenger: \(Int(route.expectedTravelTime / 60))")
//                print("DEBUG: Distance from passenger to driver: \(route.distance.distanceInMilesString())")
//                
//                self.trip?.travelTimeToPassenger = Int(route.expectedTravelTime / 60)
//                self.trip?.distanceToPassenger = route.distance
//            }
//        }
//    }
    
    func rejectTrip() {
        updateTripState(state: .rejected)
    }
    
    func acceptTrip() {
        updateTripState(state: .accepted)
    }
    
    func cancelTripAsDriver() {
        updateTripState(state: .driverCanelled)
    }
    
}


// MARK: - Location Search Helpers

extension HomeViewModel {
    
    func addressFromPlacemark(_ placemark: CLPlacemark) -> String {
        var result = ""
        
        if let thoroughfare = placemark.thoroughfare {
            result += thoroughfare
        }
        
        if let subThoroughfare = placemark.subThoroughfare {
            result += " \(subThoroughfare)"
        }
        
        if let subAdministrativeArea = placemark.subAdministrativeArea {
            result += ", \(subAdministrativeArea)"
        }
        return result
        
    }
    
    func getPlacemark(forLocation location: CLLocation, completion: @escaping(CLPlacemark?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            completion(placemark, nil)
        }
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion, config: LocationResultViewConfig) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location Search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedDriveNowLocation = DriveNowLocation(title: localSearch.title, coordinate: coordinate)
                
            case .saveLocation(let viewModel):
                print("DEBUG: Saved Location coordinates are \(coordinate)")
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let savedLocation = SavedLocation(title: localSearch.title, address: localSearch.subtitle, coordinates: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.databaseKey : encodedLocation
                ])
            }
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedDriveNowLocation?.coordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
        
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error: \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.configurePickUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}


extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
