//
//  HomeView.swift
//  DriveNow
//
//  Created by Saurabh Jaiswal on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
//    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else if let user = authViewModel.currentUser {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                    .onAppear {
                        showSideMenu = false
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                DNMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView()
                } else if mapState == .noInput{
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if let user = authViewModel.currentUser {
                if user.accountType == .passenger {
                    if mapState == .locationSelected || mapState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripRequested {
                        // show trip loading view
                        TripLoadingView()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripAccepted {
                        // show trip accepted view
                        TripAcceptedView()
                            .transition(.move(edge: .bottom))
                    } else if mapState == .tripRejected {
                        // show trip rejected view
                    }
                } else {
                    if let trip = homeViewModel.trip {
                        AcceptTripView(trip: trip)
                            .transition(.move(edge: .bottom))
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                print("DEBUG: User location in home view is \(location)")
                homeViewModel.userLocation = location
            }
        }
        .onReceive(homeViewModel.$selectedDriveNowLocation) { location in
            if location != nil {
                self.mapState = .locationSelected
            }
        }
        .onReceive(homeViewModel.$trip) { trip in
            guard let trip = trip else { return }
            
            withAnimation(.spring()) {
                switch trip.state {
                case .requested:
                    print("DEBUG: Trip is requested")
                    self.mapState = .tripRequested
                case .rejected:
                    print("DEBUG: Trip is rejected")
                    self.mapState = .tripRejected
                case .accepted:
                    print("DEBUG: Trip is accepted")
                    self.mapState = .tripAccepted
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
