//
//  RegistrationView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 12/12/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var accountType: AccountType = .passenger  // Default to passenger
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                
                VStack(alignment: .leading) {
                    Text("Choose account type")
                        .font(.title2)
                        .fontWeight(.semibold)
                        
                    
                    Picker("Account Type", selection: $accountType) {
                        Text("Passenger").tag(AccountType.passenger)
                            .foregroundColor(Color.theme.primaryTextColor)
                        Text("Driver").tag(AccountType.driver)
                            .foregroundColor(Color.theme.primaryTextColor)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                .padding(.leading)
                
                
                VStack(alignment: .leading) {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname,
                                         title: "Full Name",
                                         placeholder: "Enter your name")
                        
                        CustomInputField(text: $email,
                                         title: "Email Address",
                                         placeholder: "name@example.com")
                        
                        CustomInputField(text: $password,
                                         title: "Create Password",
                                         placeholder: "Enter your password",
                                         isSecureField: true)
                    }
                    .padding(.leading)
                    Spacer()
                    // sign up button
                    Button {
                        viewModel.registerUser(withEmail: email, password: password, fullName: fullname, accountType: accountType)
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .foregroundColor(.black)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }

            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    RegistrationView()
}
