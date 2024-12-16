//
//  DeveloperPreview.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import SwiftUI
import Firebase

let dev = DeveloperPreview.shared

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let mockUser = User(
        fullName: "Saurabh Jaiswal",
        email: "saurabh@gmail.com",
        uid: NSUUID().uuidString,
        coordinates: GeoPoint(latitude: 37.785834, longitude: -122.406417),
        accountType: .passenger,
        homeLocation: nil,
        workLocation: nil
    )
}
