@main 
struct whichQuarterApp {
    static func main() {
        do {
            try entry()
        } catch {
            print(error.localizedDescription)
        }
    }
}
