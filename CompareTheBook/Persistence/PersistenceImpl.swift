import Foundation

struct PersistenceImpl: Persistence {
    private let userDefaults = UserDefaults.standard
    private let booksKey = "saved_books"

    func saveBooks(_ books: [Book]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(books)
            userDefaults.set(data, forKey: booksKey)
        } catch {
            throw CompareTheBookError.persistenceError("Failed to encode books: \(error.localizedDescription)")
        }
    }

    func fetchBooks() throws -> [Book] {
        guard let data = userDefaults.data(forKey: booksKey) else {
            return []
        }

        let decoder = JSONDecoder()

        do {
            let books = try decoder.decode([Book].self, from: data)
            return books
        } catch {
            throw CompareTheBookError.persistenceError("Failed to decode books: \(error.localizedDescription)")
        }
    }
}
