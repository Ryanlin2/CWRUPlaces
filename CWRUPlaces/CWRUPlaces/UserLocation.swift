//
//  UserLocation.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation

struct UserLocation: Identifiable, Codable {
    let id = UUID()
    let user: String
    let lat: Double
    let lng: Double
    let label: String

    enum CodingKeys: String, CodingKey {
        case user, lat, lng, label
    }
}

struct LocationsResponse: Codable {
    let locations: [UserLocation]
}
