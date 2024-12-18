//
//  GeoPoint.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 17/12/24.
//

import Firebase
import CoreLocation

extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}