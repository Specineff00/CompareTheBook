import Foundation

struct Book: Codable, Identifiable, Equatable {
    struct Author: Codable, Equatable {
        let name: String
    }

    let title: String
    let authors: [Author]
    let coverID: Int
    var id: Int { coverID }

    enum CodingKeys: String, CodingKey {
        case title, authors
        case coverID = "cover_id"
    }
}
