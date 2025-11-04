import Foundation

func provide_quarter(_ input: String) throws -> String {
    print("Trying quarter..")

    if let q_num = Int(input), (1...4).contains(q_num) {
        let quarter = try Quarter(from: q_num)
        return try quarter.printable()
    } else {
        if let quarter = Quarter(rawValue: input.lowercased()) {
            let ordered = try quarter.see().printable()
            let output = """
            \(quarter.rawValue): 

            \(ordered)
            """
            return output
        }
    } 

    throw IndexingError.invalidName(input)
}
