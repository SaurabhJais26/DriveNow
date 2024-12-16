//
//  SavedLocationViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import Foundation

enum SavedLocationViewModel: Int, CaseIterable, Identifiable {
    case home
    case work
    
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .work: return "Work"
        }
    }
    
    var imageName: String {
        switch self {
        case .home: return "house.circle.fill"
        case .work: return "archivebox.circle.fill"
        }
    }
    
    var subtitle: String {
        switch self {
        case .home: return "Add Home"
        case .work: return "Add Work"
        }
    }
    
    var databaseKey: String {
        switch self {
        case .home: return "homeLocation"
        case .work: return "workLocation"
        }
    }
    
    var id: Int {
        return self.rawValue
    }
}
