//
//  AuthViewModel.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 13/12/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init () {
        userSession = Auth.auth().currentUser
        fetchUser()
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
            guard let firebaseUser = result?.user else { return }  // Unwraping the optional value
            self.userSession = firebaseUser
            
            let user = User(
                fullName: fullName,
                email: email,
                uid: firebaseUser.uid,
                coordinates: GeoPoint(latitude: 37.785834, longitude: -122.406417),
                accountType: .driver
            )
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return } // taking user object and encoded it into like a data dictionary that Firebase can read and I can now send this encoded object up
            
//            like if we do old fashioned way like so instead our object encodedUser can handle this using firebase firestore encoder
//            let data: [String: Any] = [
//                "fullName": fullName,
//                "email": email
//                , "uid": firebaseUser.uid
//            ]
            
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
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
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            self.currentUser = user
            print("DEBUG: Current User is: \(user)")
            
        }
    }
}
