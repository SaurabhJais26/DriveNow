//
//  LoginView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 12/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                // image and title
                VStack(spacing: -64) {
                    // image
                    Image("DriveNowIcon")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    // title
                    Text("DRIVE NOW")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                
                // input fields
                VStack(spacing: 32) {
                    // input field 1
                    CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                    
                    // input field 2
                    CustomInputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    
                    Button {
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // social sign in view
                VStack {
                    // dividers + text
                    HStack(spacing: 24) {
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundColor(.white)
                            .opacity(0.5)
                        
                        Text("Sign in with social")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Rectangle()
                            .frame(width: 76, height: 1)
                            .foregroundColor(.white)
                            .opacity(0.5)
                    }
                    // sign up buttons
                    HStack(spacing: 24) {
                        Button {
                            
                        } label: {
                            Image("facebookSignInIcon")
                                .resizable()
                                .frame(width: 48, height: 48)
                        }
                        
                        Button {
                            
                        } label: {
                            Image("GoogleSignInIcon")
                                .resizable()
                                .frame(width: 48, height: 48)
                        }

                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                // sign in button
                Button {
                    
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .foregroundColor(.black)
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                .background(Color.white)
                .cornerRadius(25)

                Spacer()
                // sign up button
                
                Button {
                    
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign Up")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                }

            }
        }
    }
}

#Preview {
    LoginView()
}
