import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharactersResult: Codable {
    let info: Info
    let results: [RMCharacter]
}

protocol RMClient {
    func downloadChars(page: Int) async throws -> CharactersResult
    func downloadChars(url: String) async throws -> CharactersResult
    func downloadEpisodes(ids: [String]) async throws -> [RMEpisode]
}

final class RMClientDefault: RMClient {
    private let performer: ApiPerformer = ApiPerformer()
    
    func downloadChars(page: Int) async throws -> CharactersResult {
        let charData = try await performer.getRequest(components: "character/?page=\(page)")
        let result: CharactersResult = try performer.decodeData(data: charData)
        return result
    }
    
    func downloadChars(url: String) async throws -> CharactersResult {
        let charData = try await performer.getRequest(url: url)
        let result: CharactersResult = try performer.decodeData(data: charData)
        return result
    }
    
    func downloadEpisodes(ids: [String]) async throws -> [RMEpisode] {
        func getNumberFromString(if stringId: String) -> String {
            stringId.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        }
        let ids = ids.map(getNumberFromString).joined(separator: ",")
        let data = try await performer.getRequest(components: "episode/[\(ids)]")
        let result: [RMEpisode] = try performer.decodeData(data: data)
        return result
    }
}
