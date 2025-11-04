import Foundation

func provide_quarter(
    _ input: String,
    _ verbose: Bool = false
) throws -> String {
    if verbose {
        print("Trying quarter with '\(input)'")
        print()
    }

    if let q_num = Int(input), (1...4).contains(q_num) {
        let quarter = try Quarter(from: q_num)
        if verbose {
            print("Found match for '\(input)' in quarters by number")
            print()
        }
        return try quarter.printable()
    } else {
        if let quarter = Quarter(rawValue: input.lowercased()) {
            if verbose {
                print("Found match for '\(input)' in quarters by name")
                print()
            }
            return try quarter.printable()
        }
    } 

    throw IndexingError.invalidName(input)
}
