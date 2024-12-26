//
//  Trip.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 17/12/24.
//

import Firebase
import FirebaseFirestore

enum TripState: Int, Codable {
    case requested
    case rejected
    case accepted
    case passengerCanelled
    case driverCanelled
}

struct Trip: Identifiable, Codable {
    @DocumentID var tripId: String?
    let passengerUid: String
    let driverUid: String
    let passengerName: String
    let driverName: String
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    let pickUpLocationName: String
    let dropOffLocationName: String
    let pickUpLocationAddress: String
    let pickUpLocation: GeoPoint
    let dropOffLocation: GeoPoint
    let tripCost: Double
    var distanceToPassenger: Double
    var travelTimeToPassenger: Int
    var state: TripState
    
    var id: String {
        return tripId ?? ""
    }
}
