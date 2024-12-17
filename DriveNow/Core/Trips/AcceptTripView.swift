//
//  AcceptTripView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 17/12/24.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    @State private var region: MKCoordinateRegion
    let trip: Trip
    let annotationItem: DriveNowLocation
    
    init(trip: Trip) {
        let center = CLLocationCoordinate2D(latitude: trip.pickUpLocation.latitude, longitude: trip.pickUpLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        self.region = MKCoordinateRegion(center: center, span: span)
        self.trip = trip
        self.annotationItem = DriveNowLocation(title: trip.pickUpLocationName, coordinate: trip.pickUpLocation.toCoordinate())
    }
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // would you like to pick up
            VStack {
                HStack {
                    Text("Would you like to pick up this passenger?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 44)
                    
                    Spacer()
                    
                    VStack {
                        Text("10")
                            .bold()
                        Text("min")
                            .bold()
                    }
                    .frame(width: 56, height: 56)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .padding()
                
                Divider()
            }
            
            // user info view
            VStack {
                HStack {
                    Image("GoogleSignInIcon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(trip.passengerName)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(.systemYellow))
                                .imageScale(.small)
                            Text("4.8")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                            
                    }
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("Earnings")
                        
                        Text(trip.tripCost.toCurrency())
                            .font(.system(size: 24, weight: .semibold))
                    }
                }
                
                Divider()
            }
            .padding()
            
            // pick up location info view
            VStack {
                // trip location info
                HStack {
                    // address info
                    VStack(alignment: .leading, spacing: 6) {
                        Text(trip.pickUpLocationName)
                            .font(.headline)
                        Text(trip.pickUpLocationAddress)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // distance
                    VStack {
                        Text("5.2")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("mi")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding(.horizontal)
                
                // map
                Map(coordinateRegion: $region, annotationItems: [annotationItem]) { item in
                    MapMarker(coordinate: item.coordinate)
                }
                .frame(height: 220)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.6), radius: 10)
                .padding()
                // divider
                
                Divider()
            }
            // action buttons
            HStack {
                Button {
                    
                } label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemRed))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Accept")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }


            }
            .padding(.top)
            .padding(.horizontal)
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    AcceptTripView(trip: dev.mockTrip)
}
