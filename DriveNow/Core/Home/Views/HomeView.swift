//
//  HomeView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            DNMapViewRepresentable()
                .ignoresSafeArea()
            
            LocationSearchActivationView()
                .padding(.top, 72)
        }
    }
}

#Preview {
    HomeView()
}
