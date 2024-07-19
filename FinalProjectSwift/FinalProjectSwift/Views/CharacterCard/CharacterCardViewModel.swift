import SwiftUI

class CharacterCardViewModel: ObservableObject {
    let client: RMClient
    let character: RMCharacter
    @Published var episodes: [String] = []
    @Published var isLoadingEpisodes = false
    @Published var error: Error?
    
    init(client: RMClient, character: RMCharacter) {
        self.client = client
        self.character = character
    }
    
    @MainActor
    func loadEpisodes() async {
        isLoadingEpisodes = true
        do {
            episodes = try await client.downloadEpisodes(ids: character.episode).map(\.name)
        } catch {
            print(error)
            self.error = error
        }
        isLoadingEpisodes = false
    }
}
