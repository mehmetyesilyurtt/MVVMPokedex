//
//  PokedexView.swift
//  UpdatePokedex
//
//  Created by Gürkan Yeşilyurt on 4.03.2022.
//

import SwiftUI

struct PokedexView: View {
    private let gridItem = [GridItem(.flexible()),GridItem(.flexible())]
    @ObservedObject var viewModel = PokemonViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gridItem, spacing: 20) {
                    ForEach(viewModel.poke){ poke in
                        PokemonModel (pokemon: , viewModel: viewModel)
                        
                    }
                }
            }
            .navigationTitle("Pokedex")
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}

