// HW21: Protocols 
//=================================================================================================================
print("=============== Protocol syntax ===============")

// protocol SomeProtocol {
//     protocol definition goes here
// }

// Adopting a protocol
// struc someStructure: someProtocol, anotherProtocol {
//     structure defenition goes here
// }

print("=============== Protocol requirements ===============")
// Error: property in protocol must have explicit { get } or { get set }
// protocol NoNeedForGetOrSet {
//     var someInt: Int
//     var someString: String
// }

protocol ConstInt {
    let someInt: Int { get }
}
protocol NoNeedForSet {
    var someInt: Int { get }
}
protocol NeedGetAndSet {
    var someInt: Int { get set }
}

class ConstIntA: NoNeedForSet {
    var someInt: Int = 5
}

class ConstIntB: NeedGetAndSet {
    var someInt: Int = 5
}

class ReadOnlyInt: NoNeedForSet {
    var someDouble: Double
    var someInt: Int { Int(someDouble) }    // Read-only computed properties
    init(someDouble: Double) { self.someDouble = someDouble }
}

print("=============== Method requirements ===============")
protocol Incrementing {
    static var someInt: Int { get }
    static func increment() -> ()
}
class IncrementIntA: Incrementing {
    static var someInt: Int { return self.someInt }
    static func increment() { someInt = someInt + 1 }
    init(someInt: Int) { self.someInt = someInt }
}