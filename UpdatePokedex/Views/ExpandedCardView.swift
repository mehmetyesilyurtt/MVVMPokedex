import SwiftUI
import Kingfisher

struct ExpandedCardView: View {
    
   
    @Namespace var expandTransition
    @Namespace var evolutionTransition
    
    @Binding var expand: Bool
    
    let pokemon: Pokemon!
    
    @State var showEvolution = false
    @State var showStats = false
    @State var animationAmount = 0.0
    @State var rotate = false
    
    @ObservedObject var viewModel = PokeDexViewModel()
    
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 40) {
                HStack {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Button {
                        expand.toggle()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.body)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    
                }
                .padding(.top,32)
                
                KFImage(URL(string: pokemon.imageUrl))
                    .shadow(color: .white, radius: 40)
                
                Text(pokemon.description.replacingOccurrences(of: "\n", with: " "))
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                HStack{
                    if !showEvolution && !showStats{
                        VStack {
                            Text("Show Evolution")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12.0)
                                        .fill(Color.white.opacity(0.4))
                                )
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        self.showEvolution = true
                                    }
                                }
                        }
                        .matchedGeometryEffect(id: "pokemonEvolution", in: evolutionTransition)
                        
                    }
                    
                    if !showStats && !showEvolution{
                        VStack {
                            Text("Show Stats")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12.0)
                                        .fill(Color.white.opacity(0.4))
                                )
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        self.showStats = true
                                    }
                                }
                        }
                        .matchedGeometryEffect(id: "pokemonStats", in: evolutionTransition)
                    }
                }
                Spacer()
            }
            .padding()
            .blur(radius : showEvolution ? 8 : 0)
            .blur(radius : showStats ? 8 : 0)
            
            if showEvolution {
                EvolutionView(pokemon: pokemon, showEvolution: $showEvolution, viewModel: viewModel)
            }
            
            if showStats {
                BarChartView(pokemon: pokemon, showStats: $showStats)
            }
            
        }
        .padding()
        .background(Color(bgColor(forType: pokemon.type)).opacity(0.7))
        .ignoresSafeArea(.all)
        .matchedGeometryEffect(id: "pokemonCard", in: expandTransition)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct EvolutionView: View {
    
   
    let pokemon: Pokemon
    @Binding var showEvolution: Bool
    @ObservedObject var viewModel: PokeDexViewModel
    @Namespace var evolutionTransition
    
    @State var animationAmount = 0.0
    
   
    var body: some View {
        
        
        let evolutionChain = viewModel.evolutionChain(of: pokemon)
        VStack {
            HStack{
                if evolutionChain.count > 0 {
                    ForEach(evolutionChain){pokemon in
                        PokemonCardView(pokemon: pokemon)
                    }
                } else {
                    Text("Not available")
                }
            }
            .frame(width: 340)
            .cornerRadius(20)
            .padding(.vertical)
            .padding(.horizontal, 8)
            .background(Color.white.opacity(0.5))
            .cornerRadius(10)
            .shadow(color: .white, radius: 30)
            .matchedGeometryEffect(id: "pokemonEvolution", in: evolutionTransition)
            .onAppear(perform: {
                animationAmount += 360
            })
            
            Button {
                showEvolution.toggle()
            } label: {
                Image(systemName: "multiply")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            }
        }
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1.0, y: 1.0, z: 1.0)
        )
        
    }
}
