//
//  HomeViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 16/12/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var drivers = [User]()
    private let service = UserService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init () {
        fetchUser()
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users").whereField("accountType", isEqualTo: AccountType.driver.rawValue).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let drivers = documents.compactMap({ try? $0.data(as: User.self) })
            self.drivers = drivers
//            print("DEBUG: Drivers \(drivers)")
        }
    }
    
    func fetchUser() {
        service.$user
            .sink { user in
                guard let user = user else { return }
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellables)
    }
}
