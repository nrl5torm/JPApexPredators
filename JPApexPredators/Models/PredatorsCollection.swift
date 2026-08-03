//
//  Predators.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 06/07/2026.
//

import Foundation

class PredatorsCollection {
    private static var _loaded: [Predator] = []
    
    var selected: [Predator] = []
    
    init () {
        loadPredatorsOnce()
        
        selected = PredatorsCollection._loaded
    }
    
    private func loadPredatorsOnce() {
        if PredatorsCollection._loaded.count > 0 {
            return
        }
        
        if let url = Bundle.main.url(forResource: "jp_apex_predators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                PredatorsCollection._loaded = try decoder.decode([Predator].self, from: data)
                
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func filter(byName nameFilter: String) -> PredatorsCollection {
        if !nameFilter.isEmpty {
            selected = selected.filter {
                $0.name.localizedCaseInsensitiveContains(nameFilter)
            }
        }
        return self
    }
    
    func filter(byEnvironment environmentFilter: Environment) -> PredatorsCollection {
        if environmentFilter != .all {
            selected = selected.filter { ap in
                ap.environment == environmentFilter
            }
        }
        return self
    }
    
    func sort(by isAlphabetical: Bool) -> PredatorsCollection {
        selected.sort { ap1, ap2 in
            if isAlphabetical {
                ap1.name.localizedLowercase < ap2.name.localizedLowercase
            } else {
                // chronological (movie appearance)
                ap1.id < ap2.id
            }
        }
        return self
    }
}
