import Foundation

enum Quarter: String, RawRepresentable, CaseIterable {
    case q1 
    case q2 
    case q3 
    case q4 

    var int: Int { 
        switch self {
        case .q1: return 1
        case .q2: return 2
        case .q3: return 3
        case .q4: return 4
        }
    }

    func short(capitalized: Bool = true) -> String { 
        let label = capitalized ? "Q" : "q"
        return label + String(self.int)
    }

    func named(capitalized: Bool = true) -> String { 
        let label = capitalized ? "Quarter" : "quarter"
        return label + " " + String(self.int)
    }

    static var ordered: [Quarter: OrderedQuarter] {
        return [
            .q1: .init(
                .january,
                .february,
                .march
            ),

            .q2: .init(
                .april,
                .may,
                .june
            ),

            .q3: .init(
                .july,
                .august,
                .september
            ),

            .q4: .init(
                .october,
                .november,
                .december
            )
        ]
    }

    static func see(quarter: Quarter) throws -> OrderedQuarter {
        if let o = ordered[quarter] {
            return o
        }

        throw IndexingError.quarterMissingInDictionary(quarter)
    }

    func see() throws -> OrderedQuarter {
        if let o = Quarter.ordered[self] {
            return o
        }

        throw IndexingError.quarterMissingInDictionary(self)
    }

    static func printable(highlighting month: Month? = nil) throws -> String {
        var res = ""
        for q in Self.allCases {
            res.append(q.named(capitalized: true))
            res.append("\n\n")
            let wholeQ = try q.see().printable(highlighting: month)
            res.append(wholeQ.indent())
            res.append("\n")
        }
        return res
    }
}
