import Foundation

enum ApiPerformerError: Error {
    case InvalidURL
    case DecodeError
}

struct ErrorMessage: Codable {
    let error: String
}

struct ApiPerformer {
    var baseURL = "https://rickandmortyapi.com/api/"
    
    func getRequest(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw ApiPerformerError.InvalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func getRequest(components: String) async throws -> Data {
        guard let url = URL(string: baseURL + components) else {
            throw ApiPerformerError.InvalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func decodeData<T: Codable>(data: Data) throws -> T {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw ApiPerformerError.DecodeError
        }
    }
}
