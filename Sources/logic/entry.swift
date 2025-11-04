import Foundation
import plate

func entry() throws {
    print()

    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Provide a month name, number, or quarter.")
        return
    }
    
    let arg_1 = args[1]
    var verbose = false

    for arg in args {
        if simpleMatch(
            in: arg,
            identifiers: ["--verbose", "-v"]
        ) {
            verbose = true
        }
    }

    if simpleMatch(
        in: arg_1.lowercased(), 
        identifiers: ["quarter", "q", "quarters"]
    ) {
        guard args.count > 2 else {
            throw IndexingError.invalidNumeral
        }
        let arg_2 = args[2]

        let res = try provide_quarter(arg_2, verbose)
        print(res)
    } else {
        let res = try provide_match(arg_1, verbose)
        print(res)
    }
}
