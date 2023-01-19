import SwiftUI

struct PokeDexView: View {
    
 
    
    @Namespace var expandTransition
    @Namespace var rotateTransition
    
    @State var expand = false
    @State var selection : Pokemon?
    
    @State var showFilterButtons = false
    @State var filterApplied = false
    
    @State var animationAmount = 0.0
    @State var rotate = false
    
    @StateObject var viewModel = PokeDexViewModel()
    
 
    var body: some View {
        
        return VStack {
            if !expand {
                NavigationView {
                    ZStack(alignment: .bottomTrailing) {
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .bottom) {
                                Text("PokeDex")
                                    .font(.largeTitle)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.top,40)
                                
                                Spacer()
                                
                                Button{
                                    viewModel.shuffle(forFilter: filterApplied)
                                }
                            label:
                                {
                                    Text("Karıştır")
                                        .padding(.bottom, 9)
                                }
                                
                            }
                            .padding()
                            
                            PokemonGrid(expand: $expand, selection: $selection, filterApplied: $filterApplied, viewModel: viewModel)
                                .blur(radius: showFilterButtons ? 8:0)
                        }

                        FilterButtons(showFilterButtons: $showFilterButtons, filterApplied: $filterApplied, viewModel: viewModel)
                        
                    }
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all)
                    
                }
            }
           
            else {
                ExpandedCardView(expand: $expand, pokemon: selection)
                
            }
        }
        .transition(.slide)
        
        
    }
}

struct PokemonGrid: View {
    
    
    var gridItems = Array(repeating: GridItem(.flexible()), count: 2)
    
    @Binding var expand: Bool
    @Binding var selection : Pokemon?
    
    @Binding var filterApplied: Bool
    
    @State var animationAmount = 0.0
    @State var rotate = false
    
    @ObservedObject var viewModel: PokeDexViewModel
    
   
    var body: some View {
        ScrollView(.vertical){
            
            LazyVGrid(columns: gridItems, spacing: 20){
                let dataSource = filterApplied ? viewModel.filteredPokemon : viewModel.pokemons
                
                ForEach(dataSource){ pokemon in
                    PokemonCardView(pokemon: pokemon)
                        .rotation3DEffect(
                            .degrees(animationAmount),
                            axis: (x: 1.0, y: 1.0, z: 0.0)
                        )
                        .gesture(TapGesture()
                            .onEnded{_ in
                                self.selection = pokemon
                                withAnimation(.interpolatingSpring(stiffness: 50, damping: 0.8)){
                                    self.rotate = true
                                    self.animationAmount += 360
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        self.expand = true
                                    }
                                }
                            }
                                 
                        )
                    
                }
                
                
            }
            
        }
        
    }
}


struct PokeDexView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexView()
            .preferredColorScheme(.dark)
    }
}
