@main 
struct WhichQuarterApp {
    static func main() {
        do {
            try entry()
        } catch {
            print(error.localizedDescription)
        }
    }
}
