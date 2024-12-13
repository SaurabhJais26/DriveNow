//
//  AuthViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 13/12/24.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init () {
        userSession = Auth.auth().currentUser
    }
    
    func registerUser(withEmail email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up user with error: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Registered user successfully")
            print("DEBUG: User id: \(result?.user.uid)")
        }
        
    }
}
