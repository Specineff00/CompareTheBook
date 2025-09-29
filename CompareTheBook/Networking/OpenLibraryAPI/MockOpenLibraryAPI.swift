import Foundation

struct MockOpenLibraryAPI: OpenLibraryAPI {
    let scienceFictionResult: () throws -> [Book]

    func fetchScienceFiction() async throws -> [Book] {
        try scienceFictionResult()
    }
}
