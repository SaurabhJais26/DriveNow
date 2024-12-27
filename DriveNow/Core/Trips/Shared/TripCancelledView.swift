//
//  TripCancelledView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 27/12/24.
//

import SwiftUI

struct TripCancelledView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            Text(viewModel.tripCancelledMessage)
                .font(.headline)
                .padding(.vertical)
            
            Button {
                guard let user = viewModel.currentUser else { return }
                guard let trip = viewModel.trip else { return }
                
                if user.accountType == .passenger {
                    if trip.state == .driverCanelled {
                        viewModel.deleteTrip()
                    } else if trip.state == .passengerCanelled {
                        viewModel.trip = nil
                    }
                } else {
                    if trip.state == .passengerCanelled {
                        viewModel.deleteTrip()
                    } else if trip.state == .driverCanelled {
                        viewModel.trip = nil
                    }
                }
                
            } label: {
                Text("OK")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

        }
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.theme.secondaryBackgroundColor, radius: 20)
    }
}

#Preview {
    TripCancelledView()
}
