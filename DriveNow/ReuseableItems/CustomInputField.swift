//
//  CustomInputField.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 12/12/24.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // title
            Text(title)
                .foregroundColor(.white)
                .font(.footnote)
                .fontWeight(.semibold)
            
            // text field
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
                    
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
                
            // divider
            Rectangle()
                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
        }
    }
}

#Preview {
    CustomInputField(text: .constant(""), title: "Email", placeholder: "name@example.com")
}
