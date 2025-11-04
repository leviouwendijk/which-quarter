import Foundation
// import plate

func entry() throws {
    let args = CommandLine.arguments
    
    guard args.count > 1 else {
        print("Please provide a month name, number, or quarter.")
        return
    }
    
    let input = args[1]

    if let monthNumber = Int(input) {
        let res = try whichQuarter(monthNumber)
        print(res)
    } else {
        let res = try whichQuarter(input)
        print(res)
    }
}
