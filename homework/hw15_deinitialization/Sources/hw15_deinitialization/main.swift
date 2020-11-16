// HW15: Deinitialization 
//=================================================================================================================
print("=============== Deinitializers in Action ===============")
class StackQueue {
    static var stack = [String]()
    static func push(_ item: String) {
        stack.append(item)
        print("Push complete: \(stack.count) in stack")
    }
    static func pop() -> String? {
        if stack.count > 0 {
            print("Pop complete: \(stack.count - 1) in stack")
            return stack.removeLast()
        } else {
            return nil
        }
    }
}

class App {
    var name: String
    init(name: String) {
        self.name = name
        StackQueue.push(name)
    }
    deinit {
        if let tempItem = StackQueue.pop() {
            print("Deinit...", tempItem)
        }
    }
}

var a: App? = App(name: "a") 
a = nil