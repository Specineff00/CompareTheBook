
struct OpenLibraryAPIImpl: OpenLibraryAPI {
    let baseService: BaseServiceProtocol

    init(baseService: BaseServiceProtocol = BaseServiceImpl()) {
        self.baseService = baseService
    }

    func fetchScienceFiction() async throws -> [Book] {
        try await baseService.dispatch(SubjectRequest("science_fiction")).books
    }
}
