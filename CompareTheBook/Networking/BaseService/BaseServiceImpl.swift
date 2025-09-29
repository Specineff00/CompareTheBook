import Foundation

actor BaseServiceImpl: BaseServiceProtocol {
    let baseURL: String

    init(baseURL: String = "https://pokeapi.co/api/v2") {
        self.baseURL = baseURL
    }

    func dispatch<R>(_ request: R) async throws -> R.ReturnType where R: Request {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            throw CompareTheBookError.badRequest
        }

        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(R.ReturnType.self, from: data)
        } catch {
            print(error)
            throw CompareTheBookError.decodeError
        }
    }
}
