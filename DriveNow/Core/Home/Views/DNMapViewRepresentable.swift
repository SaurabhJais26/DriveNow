//
//  DNMapViewRepresentable.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 10/12/24.
//

import SwiftUI
import MapKit

struct DNMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = locationViewModel.selectedLocation {
            print("DEBUG: Selected location in map view is \(selectedLocation)")
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension DNMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: DNMapViewRepresentable
        
        init(parent: DNMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
