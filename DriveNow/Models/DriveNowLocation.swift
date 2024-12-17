//
//  DriveNowLocation.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 12/12/24.
//

import CoreLocation

struct DriveNowLocation: Identifiable {
    let id = NSUUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
