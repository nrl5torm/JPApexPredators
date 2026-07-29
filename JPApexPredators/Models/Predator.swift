//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 06/07/2026.
//

import SwiftUI
import MapKit

struct Predator: Decodable, Identifiable {
    let id: Int
    
    let name: String
    let environment: Environment
    
    let latitude: Double
    let longitude: Double
    
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}
