//
//  HomeViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published var drivers = [User]()
    
    init () {
        fetchDrivers()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users").whereField("accountType", isEqualTo: AccountType.driver.rawValue).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let drivers = documents.compactMap({ try? $0.data(as: User.self) })
            self.drivers = drivers
//            print("DEBUG: Drivers \(drivers)")
        }
    }
}
