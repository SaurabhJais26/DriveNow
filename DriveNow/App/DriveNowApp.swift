//
//  DriveNowApp.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 09/12/24.
//

import SwiftUI

@main
struct DriveNowApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
