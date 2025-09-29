protocol Persistence {
    func saveBooks(_ books: [Book]) throws
    func fetchBooks() throws -> [Book]
}
