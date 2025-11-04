import Foundation
import plate

func provide_match(_ input: String) throws -> String {
    var month: Month? = nil
    
    if let m_num = Int(input), (1...12).contains(m_num) {
        month = try Month(from: m_num)
    } else {
        // check if quarter was directly entered
        // if let quarter = Quarter(rawValue: monthName.lowercased()) {
        //     let ordered = try quarter.see().printable()
        //     let output = """
        //     \(quarter.rawValue): 

        //     \(ordered)
        //     """
        //     return output
        // }
        if let q = try? provide_quarter(input) {
            return q
        }

        month = try Month(name: input)
    }
    // else {
    //     return "Invalid input. Please enter a valid month name, number, or quarter."
    // }
    
    if let m = month {
        return try m.printable()
    } 

    let stringified_in = String(describing: input)
    throw IndexingError.invalidName(stringified_in)
}
