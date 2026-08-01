//
//  PredatorMapView.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 31/07/2026.
//

import SwiftUI
import MapKit

struct PredatorMapView: View {
    let predators = PredatorsCollection().selected
    
    @State var position: MapCameraPosition
    @State var showingSatelliteView = false
    
    var body: some View {
        Map(position: $position) {
            
            ForEach(predators) { predator in
                
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                        .shadow(color: .black, radius: 7)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(showingSatelliteView ?
            .imagery(elevation: .realistic) : .standard)
        .overlay(alignment: .bottomTrailing) {
            Button {
                showingSatelliteView.toggle()
            } label: {
                Image(systemName:
                        "globe.americas\(showingSatelliteView ? ".fill" : "")")
                .font(.largeTitle)
                .imageScale(.large)
                .padding(3)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 3)
                .padding()
            }

        }

    }
}

#Preview {
    let predator = PredatorsCollection().selected[2]

    PredatorMapView(position: .camera(MapCamera(
        centerCoordinate: predator.location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    )
    .preferredColorScheme(.dark)
}
