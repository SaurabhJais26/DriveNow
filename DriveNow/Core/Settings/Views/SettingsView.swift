//
//  SettingsView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 15/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    private let user: User
    @EnvironmentObject var viewModel: AuthViewModel
    
    init (user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    // user info header
                    HStack {
                        Image("GoogleSignInIcon")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.fullName)
                                .font(.system(size: 16, weight: .semibold))
                            Text(user.email)
                                .font(.system(size: 14))
                                .accentColor(Color.theme.primaryTextColor)
                                .opacity(0.77)
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .imageScale(.small)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                }
                
                Section("Favorites") {
                    ForEach(SavedLocationViewModel.allCases) { viewModel in
                        NavigationLink {
                            Text(viewModel.title)
                        } label: {
                            SavedLocationRowView(viewModel: viewModel)
                        }
                    }
                }
                Section("Setings") {
                    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                    SettingsRowView(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))

                }
                Section("Account") {
                    SettingsRowView(imageName: "dollarsign.square.fill", title: "Make money driving", tintColor: Color(.systemGreen))
                    
                    SettingsRowView(imageName: "arrow.left.square.fill", title: "Sign out", tintColor: Color(.systemRed))
                        .onTapGesture {
                            print("DEBUG: Sign out here...")
                            viewModel.signOut()
                        }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView(user: User(fullName: "John Doe", email: "johndoe@gmail.com", uid: "123456"))
    }
}
