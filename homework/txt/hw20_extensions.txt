// HW20: Extensions 
//=================================================================================================================
print("=============== Extension syntax ===============")
// extension SomeType: SomeProtocol, AnotherProtocol {
//     **add some new functionality**
// }

print("=============== Computed properties from extensions ===============")
extension Int {
    var increment: Int { return self + 1 }
}
var a = 5
var b = a.increment
print(a, b)     // 5 6

// Error: extensions must not contain stored properties!
// extension Double {
//     let hiddenNumber: Double = 1.23
// }

print("=============== Initializers from extensions ===============")
struct Socket {
    var socketType: SocketType
    var socketProtocol: SocketProtocol
}
enum SocketType {
    case tcp, udp
}
enum SocketProtocol {
    case ipv4, ipv6
}

// Memberwise init
let http1 = Socket(socketType: .tcp, socketProtocol: .ipv4)

extension Socket {
    init?(socketType: SocketType, ipv: UInt) {
        if ipv == 4 {
            self.init(socketType: socketType, socketProtocol: SocketProtocol.ipv4)
        } else if ipv == 6 {
            self.init(socketType: socketType, socketProtocol: SocketProtocol.ipv6)
        } else {
            return nil
        }
    }
    var description: String {
        return "Socket with \(socketType) & \(socketProtocol)"
    }
}
if let http3 = Socket(socketType: .udp, ipv: 6) {
    print(http3.description)
}
// Socket with udp & ipv6
let http9 = Socket(socketType: .udp, ipv: 9)
print(http9?.description)
// nil

// Convenience init from extensions
class User {
    var name: String
    init(name: String) { self.name = name }
}
extension User {
    convenience init() { self.init(name: "NULL")}

    // Error: Designated initializer cannot be declared in an extension
    // init?(optionalName: String?) {
    //     if let tempName = optionalName { 
    //         self.name = tempName
    //     } else { 
    //         return nil
    //     }
    // }
    convenience init?(optionalName: String?) {
        if let tempName = optionalName { 
            self.init(name: tempName)
        } else { 
            return nil
        }
    }

}
let nullUser = User()
print(nullUser.name)    // NULL
let nilUser = User(optionalName: nil)
print(nilUser?.name)    // nil

print("=============== Methods & Nested types from extensions ===============")
class MyOddNumber {
    var num: UInt
    init(num: UInt) { self.num = num}
}
extension MyOddNumber {
    enum ValueError: Error {
        case isZero
        case isEven
    }
    func checkError(from num: UInt) throws {
        guard num != 0 else {
            throw ValueError.isZero
        }
        guard num % 2 != 0 else {
            throw ValueError.isEven
        }
    }
    func checkValue(with: (UInt) throws -> ()) {
        do {
            try checkError(from: num)
            print("\(num) is an odd number")
        } catch ValueError.isZero {
            print("\(num) is zero")
            num = 1
            print("change to \(num)")
        } catch ValueError.isEven {
            print("\(num) is an even number")
            num = num + 1
            print("change to \(num)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
let someNumA = MyOddNumber(num: 0)
let someNumB = MyOddNumber(num: 10)
someNumA.checkValue(with: someNumA.checkError)
// 0 is zero
// change to 1
someNumB.checkValue(with: someNumB.checkError)
// 10 is an even number
// change to 11

print("=============== Overriding methods in extensions? ===============")
class Food {
    var name: String
    init(name: String) { self.name = name }
    func description() -> String {
        return "Food: \(name)"
    }
}

class ThaiFood: Food {
    var isSpicy: Bool
    init(name: String, isSpicy: Bool) {
        self.isSpicy = isSpicy
        super.init(name: name)
    }
}

extension ThaiFood {
    // Error: overriding declarations in extensions is not supported
    // override func description() -> String {
    //     return """
    //         Food: \(name)
    //         Spicy: \(isSpicy)
    //         """
    // }
    // Extension can add new functionality to a type, but they cannot
    // override existing functionality!
}