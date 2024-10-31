// To see quickly what quarter a month belongs to and its position within the quarter
import Foundation

enum Month: Int, CaseIterable {
    case january = 1, february, march, april, may, june
    case july, august, september, october, november, december
    
    init?(name: String) {
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
        default: return nil
        }
    }
}



enum Quarter: String {
    case q1 = "q1"
    case q2 = "q2"
    case q3 = "q3"
    case q4 = "q4"
    
    // Updated to return both quarter and position within the quarter
    static func from(month: Month) -> (quarter: Quarter, position: String) {
        switch month {
        case .january: return (.q1, "beginning")
        case .february: return (.q1, "middle")
        case .march: return (.q1, "ending")
        case .april: return (.q2, "beginning")
        case .may: return (.q2, "middle")
        case .june: return (.q2, "ending")
        case .july: return (.q3, "beginning")
        case .august: return (.q3, "middle")
        case .september: return (.q3, "ending")
        case .october: return (.q4, "beginning")
        case .november: return (.q4, "middle")
        case .december: return (.q4, "ending")
        }
    }
}

func whichQuarter(_ input: Any) -> String {
    let month: Month?
    
    if let monthNumber = input as? Int, (1...12).contains(monthNumber) {
        month = Month(rawValue: monthNumber)
    } else if let monthName = input as? String {
        month = Month(name: monthName)
    } else {
        return "Invalid input. Please enter a valid month name or number."
    }
    
    if let month = month {
        let (quarter, position) = Quarter.from(month: month)
        return "\(month): \(quarter.rawValue), \(position)"
    } else {
        return "Invalid month input."
    }
}

func main() {
    print("")
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Please provide a month name or number.")
        return
    }
    
    let input = args[1]
    
    if let monthNumber = Int(input) {
        print(whichQuarter(monthNumber))
    } else {
        print(whichQuarter(input))
    }
    print("")
}

main()


