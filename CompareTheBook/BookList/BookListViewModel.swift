import Foundation
import SwiftUI

@Observable
final class BookListViewModel {
    var screenState: ScreenState = .loading

    enum ScreenState: Equatable {
        case loading
        case error(String)
        case loaded([Book])

        var getBooks: [Book] {
            switch self {
            case let .loaded(books):
                return books
            default:
                return []
            }
        }
    }

    private let apiService: OpenLibraryAPI
    private let persistence: Persistence

    init(
        apiService: OpenLibraryAPI = OpenLibraryAPIImpl(),
        persistence: Persistence = PersistenceImpl()
    ) {
        self.apiService = apiService
        self.persistence = persistence
    }

    @MainActor
    func loadBooks() async {
        screenState = .loading
        do {
            let fetchedBooks = try await apiService.fetchScienceFiction()
            screenState = .loaded(fetchedBooks)
            try persistence.saveBooks(fetchedBooks)
        } catch {
            handleError(error)
        }
    }

    @MainActor
    func loadSavedBooks() {
        do {
            let fetchedSavedBooks = try persistence.fetchBooks()
            screenState = .loaded(fetchedSavedBooks)
        } catch {
            handleError(error)
        }
    }

    @MainActor
    func refreshBooks() async {
        await loadBooks()
    }

    @MainActor
    func clearBooks() {
        screenState = .loaded([])
    }

    @MainActor
    func saveCurrentBooks() {
        do {
            try persistence.saveBooks(screenState.getBooks)
        } catch {
            handleError(error)
        }
    }

    private func handleError(_ error: Error) {
        var errorMessage = ""
        if let compareError = error as? CompareTheBookError {
            switch compareError {
            case .badRequest:
                errorMessage = "Invalid request. Please try again."
            case .decodeError:
                errorMessage = "Failed to decode book data."
            case let .load(underlyingError):
                errorMessage = "Network error: \(underlyingError.localizedDescription)"
            case let .persistenceError(message):
                errorMessage = "Storage error: \(message)"
            }
        } else {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }

        screenState = .error(errorMessage)
    }
}
