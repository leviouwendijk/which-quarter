import Foundation
import plate

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

enum Month: String, RawRepresentable, CaseIterable {
    // case january = 1
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
}

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

struct OrderedQuarter {
    let leading: Month
    let middle: Month
    let trailing: Month
    
    init(
        _ leading: Month,
        _ middle: Month,
        _ trailing: Month
    ) {
        self.leading = leading
        self.middle = middle
        self.trailing = trailing
    }

    func month(for position: QuarterOrderPosition) -> Month {
        switch position {
        case .leading: return self.leading
        case .middle: return self.middle
        case .trailing: return self.trailing
        }
    }

    func printable(highlighting month: Month? = nil) -> String {
        var res = ""

        if leading == month {
            res.append("\(QuarterOrderPosition.leading.rawValue): \(leading.cased)".ansi(.bold, .yellow))
        } else {
            res.append("\(QuarterOrderPosition.leading.rawValue): \(leading.cased)")
        }

        res.append("\n")

        if middle == month {
            res.append("\(QuarterOrderPosition.middle.rawValue): \(middle.cased)".ansi(.bold, .yellow))
        } else {
            res.append("\(QuarterOrderPosition.middle.rawValue): \(middle.cased)")
        }

        res.append("\n")

        if trailing == month {
            res.append("\(QuarterOrderPosition.trailing.rawValue): \(trailing.cased)".ansi(.bold, .yellow))
        } else {
            res.append("\(QuarterOrderPosition.trailing.rawValue): \(trailing.cased)")
        }

        res.append("\n")

        return res
    }
}

enum Quarter: String, RawRepresentable, CaseIterable {
    case q1 = "q1"
    case q2 = "q2"
    case q3 = "q3"
    case q4 = "q4"

    var int: Int { 
        switch self {
        case .q1: return 1
        case .q2: return 2
        case .q3: return 3
        case .q4: return 4
        }
    }

    func short(capitalized: Bool = true) -> String { 
        let label = capitalized ? "Q" : "q"
        return label + String(self.int)
    }

    func named(capitalized: Bool = true) -> String { 
        let label = capitalized ? "Quarter" : "quarter"
        return label + " " + String(self.int)
    }

    static var ordered: [Quarter: OrderedQuarter] {
        return [
            .q1: .init(
                .january,
                .february,
                .march
            ),

            .q2: .init(
                .april,
                .may,
                .june
            ),

            .q3: .init(
                .july,
                .august,
                .september
            ),

            .q4: .init(
                .october,
                .november,
                .december
            )
        ]
    }

    static func see(quarter: Quarter) throws -> OrderedQuarter {
        if let o = ordered[quarter] {
            return o
        }

        throw IndexingError.quarterMissingInDictionary(quarter)
    }

    func see() throws -> OrderedQuarter {
        if let o = Quarter.ordered[self] {
            return o
        }

        throw IndexingError.quarterMissingInDictionary(self)
    }

    static func printable(highlighting month: Month? = nil) throws -> String {
        var res = ""
        for q in Self.allCases {
            res.append(q.named(capitalized: true))
            res.append("\n\n")
            let wholeQ = try q.see().printable(highlighting: month)
            res.append(wholeQ.indent())
            res.append("\n")
        }
        return res
    }
}

func whichQuarter(_ input: Any) throws -> String {
    let month: Month?
    
    if let monthNumber = input as? Int, (1...12).contains(monthNumber) {
        month = try Month(from: monthNumber)
    } else if let monthName = input as? String {
        if let quarter = Quarter(rawValue: monthName.lowercased()) {
            let ordered = try quarter.see().printable()
            let output = """
            \(quarter.rawValue): 

            \(ordered)
            """
            // \(quarter.monthsInQuarter())
            return output
        }
        month = try Month(name: monthName)
    } else {
        return "Invalid input. Please enter a valid month name, number, or quarter."
    }
    
    if let month = month {
        var res = ""
        let (quarter, position) = month.quarter_position
        // let wholeQ = try quarter.see().printable(highlighting: month)
        let wholeY = try Quarter.printable(highlighting: month)
        res.append("Month: ")
        res.append("\(month.int)".ansi(.bold))
        res.append("\n")
        res.append("Name: ")
        res.append("\(month.cased)".ansi(.bold))
        res.append("\n")
        res.append("Quarter: \(quarter.short()), at position: \(position.printable)")
        res.append("\n\n")
        // res.append(wholeQ.indent())
        res.append(wholeY)
        return res
    } else {
        return "Invalid month input."
    }
}

func entry() throws {
    // print("")
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Please provide a month name, number, or quarter.")
        return
    }
    
    let input = args[1]

    if let monthNumber = Int(input) {
        let res = try whichQuarter(monthNumber)
        print(res)
    } else {
        let res = try whichQuarter(input)
        print(res)
    }
    // print("")
}
