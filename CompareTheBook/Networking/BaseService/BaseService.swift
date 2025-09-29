import Foundation

protocol BaseServiceProtocol {
    var baseURL: String { get }
    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType
}
