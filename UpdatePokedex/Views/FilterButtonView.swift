
import SwiftUI

struct FilterButtons: View {
    

    @Binding var showFilterButtons: Bool
    @Binding var filterApplied: Bool
    
    @ObservedObject var viewModel: PokeDexViewModel
    

    var body: some View {
        let toggleState = {
            filterApplied.toggle()
            showFilterButtons.toggle()
        }
        VStack {
            if showFilterButtons {
                FilterButtonView(imageName: "flame", backgroundColor: .red) {
                    toggleState()
                    viewModel.filterPokemon(by: "fire")
                }
                FilterButtonView(imageName: "leaf", backgroundColor: .green) {
                    toggleState()
                    viewModel.filterPokemon(by: "poison")
                    
                }
                FilterButtonView(imageName: "drop", backgroundColor: .blue) {
                    toggleState()
                    viewModel.filterPokemon(by: "water")
                    
                }
                FilterButtonView(imageName: "bolt", backgroundColor: .yellow) {
                    toggleState()
                    viewModel.filterPokemon(by: "electric")
                }
            }
            
            let imageName = filterApplied ? "multiply" : "line.horizontal.3.decrease"
            
            FilterButtonView(imageName: imageName, height: 36, width: 36) {
                filterApplied ? filterApplied.toggle() : showFilterButtons.toggle()
            }
            .rotationEffect(.init(degrees: self.showFilterButtons ? 180 : 0))
            
        }
        .padding()
        .animation(.spring())

    }
}

struct FilterButtonView: View {
   
    var imageName: String
    var height: CGFloat = 24
    var width: CGFloat = 24
    var backgroundColor: Color = .purple

    var action: () -> Void
    
   
    var body: some View {
        Button(action: { action() }, label: {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .padding(16)
        })
        .background(backgroundColor)
        .foregroundColor(.white)
        .clipShape(Circle())
        .shadow(color: .black, radius: 30, x: 0.0, y: 0.0)
    }
}
