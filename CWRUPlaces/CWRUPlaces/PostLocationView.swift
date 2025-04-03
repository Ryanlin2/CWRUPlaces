//
//  PostLocationView.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation
import SwiftUI



struct PostLocationView: View {
    @ObservedObject var locationManager = LocationManager()
    @StateObject var viewModel = LocationViewModel()

    @State private var labelText = ""

    var body: some View {
        VStack(spacing: 0) {
            MapView(viewModel: viewModel)
                .frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)

            VStack {
                TextField("Add a label (max 25 chars)", text: $labelText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Post My Location") {
                    guard let coord = locationManager.location else { return }
                    let post = PostLocation(
                        user: "rhl72",
                        pass: 3538309,
                        lat: coord.latitude,
                        lng: coord.longitude,
                        label: String(labelText.prefix(25))
                    )
                    viewModel.postLocation(post: post)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}

#Preview{
    PostLocationView()
}

