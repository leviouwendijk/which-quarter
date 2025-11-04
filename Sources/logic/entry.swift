import Foundation
import plate

func entry() throws {
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Provide a month name, number, or quarter.")
        return
    }
    
    let arg_1 = args[1]

    if simpleMatch(
        in: arg_1.lowercased(), 
        identifiers: ["quarter", "q"]
    ) {
        guard args.count > 2 else {
            throw IndexingError.invalidNumeral
        }
        let arg_2 = args[2]

        let res = try provide_quarter(arg_2)
        print(res)
    } else {
        let res = try provide_match(arg_1)
        print(res)
    }
}
