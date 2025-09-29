struct Root: Decodable {
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case books = "works"
    }
}
