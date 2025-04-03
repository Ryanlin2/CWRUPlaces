//
//  MapView.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: LocationViewModel
    @ObservedObject var locationManager = LocationManager()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.507, longitude: -81.61),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: viewModel.locations
        ) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)) {
                VStack {
                    Text(location.user).bold()
                    Text(location.label).font(.caption)
                }
                .padding(5)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
        .onAppear {
            viewModel.fetchLocations()
            viewModel.startTimer()
        }
        .onReceive(locationManager.$location) { loc in
            guard let loc = loc else { return }
            region.center = loc
        }
    }
}

