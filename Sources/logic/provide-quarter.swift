import Foundation

func provide_quarter(_ input: String) throws -> String {
    print("Trying quarter..")
    print()

    if let q_num = Int(input), (1...4).contains(q_num) {
        let quarter = try Quarter(from: q_num)
        return try quarter.printable()
    } else {
        if let quarter = Quarter(rawValue: input.lowercased()) {
            return try quarter.printable()
        }
    } 

    throw IndexingError.invalidName(input)
}
