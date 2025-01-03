//
//  MapViewState.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 10/12/24.
//

import Foundation

enum MapViewState {
    case noInput
    case searchingForLocation
    case locationSelected
    case polylineAdded
    case tripRequested
    case tripRejected
    case tripAccepted
    case tripCancelledByPassenger
    case tripCancelledByDriver
}
