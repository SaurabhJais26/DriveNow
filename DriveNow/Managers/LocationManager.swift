//
//  LocationManager.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 10/12/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest       // This gives most accurate user location possible
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
