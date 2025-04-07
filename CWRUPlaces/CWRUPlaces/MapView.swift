//
//  MapView.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation
import MapKit
import SwiftUI
import Observation

struct MapView: View {
    var viewModel: LocationViewModel
    @State private var locationManager = LocationManager()

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.507, longitude: -81.61),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(viewModel.locations) { location in
                Annotation(
                    location.user,
                    coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
                ) {
                    VStack(spacing: 2) {
                        Text(location.user)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.blue)

                        Text(location.label)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(6)
                    .background( in: RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
                    .opacity(5.0)
                }
            }
        }
        .mapStyle(.standard)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.fetchLocations()
            viewModel.startTimer()
        }
        .onChange(of: locationManager.location) {
            if let loc = locationManager.location {
                withAnimation {
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: loc,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                }
            }
        }

    }
}
