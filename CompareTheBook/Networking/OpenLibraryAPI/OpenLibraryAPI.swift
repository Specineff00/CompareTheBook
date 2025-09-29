protocol OpenLibraryAPI {
    func fetchScienceFiction() async throws -> [Book]
}
