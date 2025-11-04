import Foundation
import plate

func whichQuarter(_ input: Any) throws -> String {
    let month: Month?
    
    if let monthNumber = input as? Int, (1...12).contains(monthNumber) {
        month = try Month(from: monthNumber)
    } else if let monthName = input as? String {
        if let quarter = Quarter(rawValue: monthName.lowercased()) {
            let ordered = try quarter.see().printable()
            let output = """
            \(quarter.rawValue): 

            \(ordered)
            """
            return output
        }
        month = try Month(name: monthName)
    } else {
        return "Invalid input. Please enter a valid month name, number, or quarter."
    }
    
    if let month = month {
        var res = ""
        let (quarter, position) = month.quarter_position
        // let wholeQ = try quarter.see().printable(highlighting: month)
        let wholeY = try Quarter.printable(highlighting: month)
        res.append("Month: ")
        res.append("\(month.int)".ansi(.bold))
        res.append("\n")
        res.append("Name: ")
        res.append("\(month.cased)".ansi(.bold))
        res.append("\n")
        res.append("Quarter: \(quarter.short()), at position: \(position.printable)")
        res.append("\n\n")
        // res.append(wholeQ.indent())
        res.append(wholeY)
        return res
    } else {
        return "Invalid month input."
    }
}
