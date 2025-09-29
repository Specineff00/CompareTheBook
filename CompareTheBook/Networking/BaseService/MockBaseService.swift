import Foundation

struct MockBaseService: BaseServiceProtocol {
    var baseURL: String = "baseurl.com"
    var dispatchHandler: (Any) throws -> Any

    init(dispatchHandler: @escaping (Any) throws -> Any) {
        self.dispatchHandler = dispatchHandler
    }

    func dispatch<R>(_ request: R) async throws -> R.ReturnType where R: Request {
        let result = try dispatchHandler(request)
        guard let returnValue = result as? R.ReturnType else {
            throw NSError(domain: "MockAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Type mismatch"])
        }
        return returnValue
    }
}
