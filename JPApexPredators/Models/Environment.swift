//
//  PredatorType.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 17/07/2026.
//

import Foundation
import SwiftUI

enum Environment: String, CaseIterable, Decodable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: Environment { self }
    
    var color: Color {
        switch self {
        
        case .land:
            return .brown
        case .air:
            return .teal
        case .sea:
            return .blue
        default:
            return .clear
        }
    }
    
    var icon: String {
        switch self {
            
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "globe.americas.fill"
        case .air:
            "wind"
        case .sea:
            "water.waves"
        }
    }
}
