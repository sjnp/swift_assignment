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
// Push complete: 1 in stack
a = nil
// Pop complete: 0 in stack
// Deinit... a

print("=============== Deinitializers of inherited class ===============")
// Super class
class Vehicle {
    var wheelCount: UInt
    init(wheelCount: UInt) {
        self.wheelCount = wheelCount
    }
    deinit {
        print("Deleting this \(wheelCount)-wheel vehicle...")
    }
}

// Inherited class
class Bike: Vehicle {
    var gearCount: UInt
    init(gearCount: UInt) {
        self.gearCount = gearCount
        super.init(wheelCount: 2)
    }
    deinit {
        ///Error: Deinit cannot be accessed
        ///super.deinit()
        print("Deleting this \(gearCount)-gear bike...")
    }
}
var mountainBike: Bike? = Bike(gearCount: 8)
mountainBike = nil
// Deleting this 8-gear bike...
// Deleting this 2-wheel vehicle...

/// ** The deinit of inherited class is called first **

/// Creating this class for testing if we can override deinitialzer???
class Motorcycle: Vehicle {
    var engineSize: UInt
    init(engineSize: UInt) {
        self.engineSize = engineSize
        super.init(wheelCount: 2)
    }

    /// Error: 'override' cannot be applied to 'deinit'
    /*
    override deinit {
        print("Deleting this \(engineSize)-cc motorcycle")
    }
    */
}

print("=============== Deinitializers from failable initializers? ===============")
class UnsignedIntFromString {
    var number: String
    init?(number: String) {
        print("Creating object from string \"\(number)\"")
        if UInt(number) != nil {
            self.number = number
        } else {
            return nil
        }
    }
    deinit {
        print("Deleting this object...")
    }
}

var two = UnsignedIntFromString(number: "02")
// Creating object from string "02"
two = nil
// Deleting this object...

var minusOne = UnsignedIntFromString(number: "-1")
// Creating object from string "-1"
minusOne = nil

/// ** The 2nd case the deinitializer is not called because of the failed initializer **

print("=============== Required Deinitializers??? ===============")
class Point {
    var number: UInt
    required init(number: UInt) {
        self.number = number
    }

    /// 'required' can only be used on 'init'
    /*
    required deinit {
        print("Deleting \(number)-point")
    }
    */
}
