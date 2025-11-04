import Foundation

func provide_match(_ input: String) throws -> String {
    var month: Month? = nil
    
    if let m_num = Int(input), (1...12).contains(m_num) {
        month = try Month(from: m_num)
    } else {
        if let q = try? provide_quarter(input) {
            return q
        }

        month = try Month(name: input)
    }
    
    if let m = month {
        return try m.printable()
    } 

    throw IndexingError.invalidName(input)
}
