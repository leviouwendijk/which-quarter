import Foundation

enum IndexingError: Error, LocalizedError {
    case invalidNumeral
    case numberNotInRange(Int)
    case invalidName(String)
    case quarterMissingInDictionary(Quarter)

    var errorDescription: String? {
        switch self {
        case .invalidNumeral:
            return "Invalid number"
        case .numberNotInRange(let num):
            return "\(num) not in range"
        case .invalidName(let name):
            return "Invalid name: '\(name)'"
        case .quarterMissingInDictionary(let q):
            return "This quarter is missing from the static dicitionary which should contain it: '\(q.rawValue)'"
        }
    }
}
