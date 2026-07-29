//
//  PredatorDetailView.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 17/07/2026.
//

import SwiftUI
import MapKit

struct PredatorDetailView: View {
    let predator: Predator
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { gr in
            
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    
                    // Background
                    Image(predator.environment.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.7),
                                Gradient.Stop(color: Color("BackgroundColor"), location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // Picture
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: gr.size.width / 1.5,
                               height: gr.size.height / 3.8)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                        .scaleEffect(x: -1)
                }
                
                VStack(alignment: .leading) {
                    // Title
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Location
                    NavigationLink {
                        Image(predator.image)
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: gr.size.height / 5)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan.circle")
                                .imageScale(.large)
                                .font(.title)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current location:")
                                .foregroundStyle(.white)
                                .padding([.leading, .trailing], 8)
                                .padding(.top, 3)
                                .padding(.bottom, 5)
                                .background(.black.opacity(0.8))
                                .clipShape(.rect(bottomTrailingRadius: 10))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                                        
                    // Movies
                    Text("Appears in:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• \(movie)")
                            .font(.subheadline)
                    }
                    
                    // Scenes
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .padding(.bottom)
                    
                }
                .padding()
                .frame(width: gr.size.width, alignment: .leading)

            }
            .scrollEdgeEffectHidden()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let predator = PredatorsCollection().selected[2]
    
    NavigationStack {
        PredatorDetailView(predator: predator,
                           position: .camera(MapCamera(
                            centerCoordinate: predator.location,
                            distance: 30000))
        )
        .preferredColorScheme(.dark)
    }
}
