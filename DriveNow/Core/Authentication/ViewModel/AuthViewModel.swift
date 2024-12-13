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
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in user with error: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Sign in successful")
            print("DEBUG: User id: \(result?.user.uid)")
            self.userSession = result?.user
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up user with error: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Registered user successfully")
            print("DEBUG: User id: \(result?.user.uid)")
            self.userSession = result?.user
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            print("DEBUG: Sign out successful")
        } catch {
            print("DEBUG: Failed to sign out user with error: \(error.localizedDescription)")
        }
    }
}
