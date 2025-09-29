import Foundation

enum CompareTheBookError: Error {
    case badRequest
    case decodeError
    case load(Error)
    case persistenceError(String)
}
