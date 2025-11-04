import Foundation

enum Month: String, RawRepresentable, CaseIterable {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    init(name: String) throws {
        let lowercasedName = name.lowercased()
        switch lowercasedName {
        case "january", "jan": self = .january
        case "february", "feb": self = .february
        case "march", "mar": self = .march
        case "april", "apr": self = .april
        case "may": self = .may
        case "june", "jun": self = .june
        case "july", "jul": self = .july
        case "august", "aug": self = .august
        case "september", "sep": self = .september
        case "october", "oct": self = .october
        case "november", "nov": self = .november
        case "december", "dec": self = .december
        default: 
            throw IndexingError.invalidName(name)
        }
    }

    init(from index: Int) throws {
        guard index > 0, index < 13 else {
            throw IndexingError.numberNotInRange(index)
        }

        switch index {
        case 1: self = .january
        case 2: self = .february
        case 3: self = .march
        case 4: self = .april
        case 5: self = .may
        case 6: self = .june
        case 7: self = .july
        case 8: self = .august
        case 9: self = .september
        case 10: self = .october
        case 11: self = .november
        case 12: self = .december
        default:
            throw IndexingError.invalidNumeral
        }
    }

    func quarter() -> Quarter {
        switch self {
        case .january,
            .february,
            .march:
            return .q1

        case .april,
            .may,
            .june:
            return .q2

        case .july,
            .august,
            .september:
            return .q3

        case .october,
            .november,
            .december:
            return .q4
        }
    }

    func position() -> QuarterOrderPosition {
        switch self {
        case .january,
            .april,
            .july,
            .october:
            return .leading

        case .february,
            .may,
            .august,
            .november:
            return .middle

        case .march,
            .june,
            .september,
            .december:
            return .trailing
        }
    }

    var quarter_position: (Quarter, QuarterOrderPosition) {
        return (quarter(), position())
    }

    var cased: String { return self.rawValue.capitalized }

    var int: Int {
        switch self {
        case .january: return 1
        case .february: return 2
        case .march: return 3
        case .april: return 4
        case .may: return 5
        case .june: return 6
        case .july: return 7
        case .august: return 8
        case .september: return 9
        case .october: return 10
        case .november: return 11
        case .december: return 12
        }
    }

    func printable() throws -> String {
        var res = ""
        let (quarter, position) = self.quarter_position
        // let wholeQ = try quarter.see().printable(highlighting: self)
        let wholeY = try Quarter.printable(highlighting: self)
        res.append("Month: ")
        res.append("\(self.int)".ansi(.bold))
        res.append("\n")
        res.append("Name: ")
        res.append("\(self.cased)".ansi(.bold))
        res.append("\n")
        res.append("Quarter: \(quarter.short()), at position: \(position.printable)")
        res.append("\n\n")
        // res.append(wholeQ.indent())
        res.append(wholeY)
        return res
    }
}
