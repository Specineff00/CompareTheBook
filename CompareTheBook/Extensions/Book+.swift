import Foundation

extension Book {
    var mediumCoverImageURL: URL? {
        .init(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")
    }
}
