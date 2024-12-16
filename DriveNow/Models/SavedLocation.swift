//
//  SavedLocation.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import Firebase


struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
}
