import Foundation

struct SubjectRequest: Request {
    typealias ReturnType = [Book]
    let path: String
    let queryItems: [URLQueryItem]?

    init(_ subject: String, limit: Int = 20) {
        path = "/subjects/\(subject).json"
        queryItems = [.init(name: "limit", value: String(limit))]
    }
}
