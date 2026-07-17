//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Olivier Sbg on 03/07/2026.
//

import SwiftUI

struct PredatorsListView: View {
    
    @State var searchName = ""
    @State var isAlphabeticalOrder = false
    @State var environmentFilter = Environment.all
    
    var filteredPredators: [Predator] {
        return PredatorsCollection()
            .filter(byEnvironment: environmentFilter)
            .filter(byName: searchName)
            .sort(by: isAlphabeticalOrder)
            .selected
    }
    
    var body: some View {

        NavigationStack {

            List(filteredPredators) { predator in
                NavigationLink {
                    PredatorDetailView()
                } label: {
                    
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .gray, radius: 2)
                        
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.environment.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.environment.color)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchName)
//            .autocorrectionDisabled()
            .animation(.default, value: searchName)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isAlphabeticalOrder.toggle()
                        }
                    } label: {
                        Image(systemName: "textformat")
//                            .symbolEffect(.bounce, value: isAlphabeticalOrder)
                    }
                    .foregroundStyle(isAlphabeticalOrder ? .white : .primary)
                    .fontWeight(isAlphabeticalOrder ? .bold: .regular)
                    .background(isAlphabeticalOrder ? .blue : .clear)
                    .clipShape(.capsule)
                }
                    
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $environmentFilter.animation()) {
                            ForEach(Environment.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
        }
        //        .preferredColorScheme(.dark)

    }
}

#Preview {
    PredatorsListView()
}
