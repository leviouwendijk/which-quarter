import Foundation
import plate

struct OrderedQuarter {
    let leading: Month
    let middle: Month
    let trailing: Month
    
    init(
        _ leading: Month,
        _ middle: Month,
        _ trailing: Month
    ) {
        self.leading = leading
        self.middle = middle
        self.trailing = trailing
    }

    func month(for position: QuarterOrderPosition) -> Month {
        switch position {
        case .leading: return self.leading
        case .middle: return self.middle
        case .trailing: return self.trailing
        }
    }

    func printable(highlighting month: Month? = nil) -> String {
        var leading_str = leading.int.string() + ". " + QuarterOrderPosition.leading.rawValue + ": " + leading.cased
        var middle_str = middle.int.string() + ". " + QuarterOrderPosition.middle.rawValue + ": " + middle.cased
        var trailing_str = trailing.int.string() + ". " + QuarterOrderPosition.trailing.rawValue + ": " + trailing.cased

        func ansify(_ s: String) -> String {
            return s.ansi(.bold, .yellow)
        }

        switch month {
        case leading:
            leading_str = ansify(leading_str)

        case middle:
            middle_str = ansify(middle_str)

        case trailing:
            trailing_str = ansify(trailing_str)

        default: 
            break
        }

        let strings = [leading_str, middle_str, trailing_str]
        var res = strings.joined(separator: "\n")
        res.append("\n")
        return res
    }
}
