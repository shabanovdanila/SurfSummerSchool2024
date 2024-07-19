import Foundation

struct RMCharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: RMLocation
    let image: String
    let episode: [String]
    let url: String
}
