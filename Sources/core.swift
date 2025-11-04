// To see quickly what quarter a month belongs to and its position within the quarter
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

// enum Month: Int, CaseIterable {
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

    var printable: String {
        return """
            \(QuarterOrderPosition.leading.rawValue): \(leading.cased)
            \(QuarterOrderPosition.middle.rawValue): \(middle.cased)
            \(QuarterOrderPosition.trailing.rawValue): \(trailing.cased)
        """
    }
}

enum Quarter: String, RawRepresentable, CaseIterable {
    case q1 = "q1"
    case q2 = "q2"
    case q3 = "q3"
    case q4 = "q4"

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
    
    // static func from(month: Month) -> (quarter: Quarter, position: String) {
    //     switch month {
    //     case .january: return (.q1, "beginning")
    //     case .february: return (.q1, "middle")
    //     case .march: return (.q1, "ending")
    //     case .april: return (.q2, "beginning")
    //     case .may: return (.q2, "middle")
    //     case .june: return (.q2, "ending")
    //     case .july: return (.q3, "beginning")
    //     case .august: return (.q3, "middle")
    //     case .september: return (.q3, "ending")
    //     case .october: return (.q4, "beginning")
    //     case .november: return (.q4, "middle")
    //     case .december: return (.q4, "ending")
    //     }
    // }
    
    // func monthsInQuarter() -> String {
    //     let monthsAndPositions: [(Int, String, String)] = {
    //         switch self {
    //         case .q1: return [
    //             (1,
    //             "January",
    //             "beginning"),
    //             (2,
    //             "February",
    //             "middle"),
    //             (3,
    //             "March",
    //             "ending")
    //         ]
    //         case .q2: return [
    //             (4,
    //             "April",
    //             "beginning"),
    //             (5,
    //             "May",
    //             "middle"),
    //             (6,
    //             "June",
    //             "ending")
    //         ]
    //         case .q3: return [
    //             (7,
    //             "July",
    //             "beginning"),
    //             (8,
    //             "August",
    //             "middle"),
    //             (9,
    //             "September",
    //             "ending")
    //         ]
    //         case .q4: return [
    //             (10,
    //             "October",
    //             "beginning"),
    //             (11,
    //             "November",
    //             "middle"),
    //             (12,
    //             "December",
    //             "ending")
    //         ]
    //         }
    //     }()
        
    //     return monthsAndPositions.map { "\($0.0) : \($0.1.lowercased()) -- \($0.2)" }.joined(separator: "\n")
    // }
}

func whichQuarter(_ input: Any) throws -> String {
    let month: Month?
    
    if let monthNumber = input as? Int, (1...12).contains(monthNumber) {
        month = try Month(from: monthNumber)
    } else if let monthName = input as? String {
        if let quarter = Quarter(rawValue: monthName.lowercased()) {
            let ordered = try quarter.see().printable
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
        let (quarter, position) = month.quarter_position
        return "\(month): \(quarter.rawValue), \(position.printable)"
    } else {
        return "Invalid month input."
    }
}

func entry() throws {
    print("")
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Please provide a month name, number, or quarter.")
        return
    }
    
    let input = args[1]

    // let result = try whichQuarter(input)
    // print(result)
    if let monthNumber = Int(input) {
        let res = try whichQuarter(monthNumber)
        print(res)
    } else {
        let res = try whichQuarter(input)
        print(res)
    }
    print("")
}
