//
//  SavedLocationRowView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 15/12/24.
//

import SwiftUI

struct SavedLocationRowView: View {
    let viewModel: SavedLocationViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundColor(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(viewModel.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
            }
        }
    }
}

#Preview {
    SavedLocationRowView(viewModel: .home)
}
