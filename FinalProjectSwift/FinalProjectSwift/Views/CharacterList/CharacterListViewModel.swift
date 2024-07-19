import Foundation
import SwiftUI

class CharacterListViewModel: ObservableObject {
    let client: RMClient
    @Published var characters: [RMCharacter]
    @Published var canLoadMore: Bool
    @Published var error: Error?
    private var nextPage: String?

    init(client: RMClient) {
        self.client = client
        characters = []
        canLoadMore = true
    }
    
    func loadNext() async {
        guard canLoadMore else {
            return
        }
        do {
            let result: CharactersResult
            if let nextPage {
                result = try await client.downloadChars(url: nextPage)
            } else {
                result = try await client.downloadChars(page: 1)
            }
            await MainActor.run {
                nextPage = result.info.next
                canLoadMore = self.nextPage != nil
                characters.append(contentsOf: result.results)
            }
        } catch {
            print(error)
            await MainActor.run {
                self.error = error
            }
        }
    }
}


