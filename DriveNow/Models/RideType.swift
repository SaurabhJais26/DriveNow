//
//  RideType.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 11/12/24.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case cabX
    case cabBlack
    case cabXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .cabX: return "CabX"
        case .cabBlack: return "CabBlack"
        case .cabXL: return "CabXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .cabX: return "cab-x"
        case .cabBlack: return "cab-black"
        case .cabXL: return "cab-xl"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .cabX: return 150
        case .cabBlack: return 250
        case .cabXL: return 450
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        switch self {
        case .cabX: return baseFare + distanceInMiles * 10
        case .cabBlack: return baseFare + distanceInMiles * 15
        case .cabXL: return baseFare + distanceInMiles * 20
        }
    }
}
