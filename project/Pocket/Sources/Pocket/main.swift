protocol Valueble {
    init(description: String, amount: Double)
}

class DailyLog {
    static var items = [Valueble]()
}

class Log {
    static var items = [Valueble]()
    static var date = 0
}

class Income: Valueble {
    let amount: Double
    let description: String
    required init(description: String, amount: Double) {
        self.description = description
        self.amount = amount
    }
}

class Expense: Valueble {
    let amount: Double
    let description: String
    required init(description: String, amount: Double) {
        self.description = description
        self.amount = -amount
    }
}

class Page {
    var menu: [String]
    var menuCount: Int { menu.count }
    var nextPage: Page?
    init(menu: [String]) { self.menu = menu }
    func showMenu() {
        for i in 1...menuCount {
            print("\(i)) \(menu[i-1])")
        }
        print("0) Exit program")
    }
}

extension Page {
    enum menuIndex: Error {
        case InvalidIndex
    }
}



let pages = [ Page(menu: ["Start a new day"]),
            Page(menu: ["Add item", "Read daily log","End the day"]),
            Page(menu: ["Start a new day","Read a log"])
            ]

var pageIndex = 0
var isRunning = true
while(isRunning) {
    pages[pageIndex].showMenu()
    print("Enter: ", terminator: "")
    let input = readLine()
}