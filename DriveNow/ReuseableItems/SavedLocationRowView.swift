//
//  SavedLocationRowView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 15/12/24.
//

import SwiftUI

struct SavedLocationRowView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
            }
        }
    }
}

#Preview {
    SavedLocationRowView(imageName: "house.circle.fill", title: "Home", subtitle: "Add Home")
}
