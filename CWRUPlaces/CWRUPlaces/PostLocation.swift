//
//  PostLocation.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation

struct PostLocation: Codable {
    let user: String
    let pass: Int
    let lat: Double
    let lng: Double
    let label: String
}

