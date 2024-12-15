//
//  SettingsView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 15/12/24.
//

import SwiftUI

struct SettingsView: View {
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
                            Text("Saurabh Jaiswal")
                                .font(.system(size: 16, weight: .semibold))
                            Text("saurabh@gmail.com")
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
                }
                
                Section("Favorites") {
                    SavedLocationRowView(imageName: "house.circle.fill", title: "Home", subtitle: "Add Home")
                    SavedLocationRowView(imageName: "archivebox.circle.fill", title: "Work", subtitle: "Add Work")
            
                }
                Section("Seetings") {
                    SettingsRowView(imageName: "bell.circle.fill", title: "Notifications", tintColor: Color(.systemPurple))
                    SettingsRowView(imageName: "creditcard.circle.fill", title: "Payment Methods", tintColor: Color(.systemBlue))

                }
                Section("Account") {
                    SettingsRowView(imageName: "dollarsign.square.fill", title: "Make money driving", tintColor: Color(.systemGreen))
                    SettingsRowView(imageName: "arrow.left.square.fill", title: "Sign out", tintColor: Color(.systemRed))
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
