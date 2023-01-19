import Foundation

struct Pokemon: Codable, Identifiable{
    
    let id: Int
    let name: String
    let type: String
    let imageUrl: String
    let description: String
    let evolutionChain: [Evolution]?
    let height: Int
    let weight: Int
    let attack: Int
    let defense: Int
    
    
    struct Evolution: Codable{
        
        let identity: String
        let nameOfEvolved: String
        
        enum CodingKeys: String, CodingKey{
            
            case identity = "id"
            case nameOfEvolved = "name"
        }
    }
}
