// To see quickly what quarter a month belongs to
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
    case Q1 = "Q1"
    case Q2 = "Q2"
    case Q3 = "Q3"
    case Q4 = "Q4"
    
    static func from(month: Month) -> Quarter {
        switch month {
        case .january, .february, .march: return .Q1
        case .april, .may, .june: return .Q2
        case .july, .august, .september: return .Q3
        case .october, .november, .december: return .Q4
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
        return Quarter.from(month: month).rawValue
    } else {
        return "Invalid month input."
    }
}

func main() {
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Please provide a month name or number.")
        return
    }
    
    let input = args[1]
    
    // Try to interpret input as an integer, else treat it as a string
    if let monthNumber = Int(input) {
        print(whichQuarter(monthNumber))
    } else {
        print(whichQuarter(input))
    }
}

main()


