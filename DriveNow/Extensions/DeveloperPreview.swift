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
    
    let mockTrip = Trip(
        id: NSUUID().uuidString,
        passengerUid: NSUUID().uuidString,
        driverUid: NSUUID().uuidString,
        passengerName: "Saurabh Jaiswal",
        driverName: "John Doe",
        passengerLocation: .init(latitude: 37.123, longitude: -122.1),
        driverLocation: .init(latitude: 37.456, longitude: -122.55),
        pickUpLocationName: "Apple Campus",
        dropOffLocationName: "Starbucks",
        pickUpLocationAddress: "123 Main St, Palo Alto, CA",
        pickUpLocation: .init(latitude: 37.789, longitude: -122.7856),
        dropOffLocation: .init(latitude: 37.210, longitude: -122.467),
        tripCost: 404.0
    )
    
}
