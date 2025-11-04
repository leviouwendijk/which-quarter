import Foundation

func provide_match(
    _ input: String,
    _ verbose: Bool = false
) throws -> String {
    if verbose {
        print("Trying any match with '\(input)'")
        print()
    }

    var month: Month? = nil
    
    if let m_num = Int(input), (1...12).contains(m_num) {
        month = try Month(from: m_num)
    } else {
        if let q = try? provide_quarter(input) {
            if verbose {
                print("Found match for '\(input)' in quarters as direct quarter name")
                print()
            }
            return q
        }

        month = try Month(name: input)
    }
    
    if let m = month {
        if verbose {
            print("Found match for '\(input)' in months")
            print()
        }
        return try m.printable()
    } 

    throw IndexingError.invalidName(input)
}
