//
//  User.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 13/12/24.
//

import Foundation


struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
