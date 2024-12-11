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
}
