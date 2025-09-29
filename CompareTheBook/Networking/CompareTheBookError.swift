import Foundation

enum CompareTheBookError: Error {
    case badRequest
    case decodeError
    case load(Error)
    case persistenceError(String)
}

extension CompareTheBookError: Equatable {
    static func == (lhs: CompareTheBookError, rhs: CompareTheBookError) -> Bool {
        switch (lhs, rhs) {
        case (.badRequest, .badRequest):
            return true
        case (.decodeError, .decodeError):
            return true
        case let (.load(lhsError), .load(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.persistenceError(lhsMessage), .persistenceError(rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
