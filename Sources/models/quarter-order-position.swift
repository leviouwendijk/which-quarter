import Foundation

enum QuarterOrderPosition: String, RawRepresentable, CaseIterable {
    case leading
    case middle
    case trailing

    var printable: String {
        switch self {
        case .leading:
            return rawValue + " (1 of 3)"
        case .middle:
            return rawValue + " (2 of 3)"
        case .trailing:
            return rawValue + " (3 of 3)"
        }
    }
}
