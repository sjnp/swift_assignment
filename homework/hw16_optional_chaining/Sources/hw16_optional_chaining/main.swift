// HW16: Optional Chaining
//=================================================================================================================
print("=============== Optional Chaining as an alternative to forced unwrapping ===============")
class Vehicle {
    var wheel: Wheel?
}

class Wheel {
    var wheelCount: UInt
    init?(wheelCount: UInt) {
        if wheelCount > 0 {
            self.wheelCount = wheelCount
        } else {
            return nil
        }
    }
}

let carA = Vehicle()

/// Optional chaining 
if let numberOfWheels = carA.wheel?.wheelCount {
    print("This is \(numberOfWheels)-wheel car")
} else {
    print("The car that has no wheel is not a car")
}
/// The car that has no wheel is not a car

/// Forced unwrapping will give an error
/// let numberOfWheels = carA.wheel!.wheelCount

carA.wheel = Wheel(wheelCount: 0)
/// Optional chaining 
if let numberOfWheels = carA.wheel?.wheelCount {
    print("This is \(numberOfWheels)-wheel car")
} else {
    print("The car that has no wheel is not a car")
}
/// The car that has no wheel is not a car

carA.wheel = Wheel(wheelCount: 4)
/// Optional chaining 
if let numberOfWheels = carA.wheel?.wheelCount {
    print("This is \(numberOfWheels)-wheel car")
} else {
    print("The car that has no wheel is not a car")
}
/// This is 4-wheel car

print("=============== Defining model class for optional chaining ===============")
class Server {
    var users = [User]()
    var userCount: Int {
        return users.count
    }
    var offlineUserCount: Int {
        var count = 0
        for user in users {
            if user.isOnline == false { count = count + 1}
        }
        return count
    }
    var onlineUserCount: Int {
        return userCount - offlineUserCount
    }
    subscript(i: Int) -> User {
        get {
            return users[i]
        }
        set {
            users[i] = newValue
        }
    }
}

class User {
    var name: String?
    var address: Address?
    init() { }
    init(name: String?, address: Address?) {
        self.name = name
        self.address = address
    }
    var isOnline: Bool { address != nil ? true : false }

    func disconnect() { address = nil }
    func connect(from address: Address?) { 
        disconnect()
        self.address = address 
    }

    func showData() {
        print("""
            name: \(name ?? "Anonymous")
            address: \(address?.getIPV4() ?? "Offline")
            """)
    }
    func getName() -> String? { return name }
    func getAddress() -> String? { return address?.ipv4 }
}

class Address {
    var ipv4: String
    init?(ipv4: String) {
        if ipv4.hasSuffix(":8080") {
            self.ipv4 = ipv4
        } else {
            return nil
        }
    }
    func getIPV4() -> String {
        return ipv4
    }
    deinit {
        print("disconnecting from \(ipv4)")
    }
}

print("=============== Accessing properties through optional chaining ===============")
let nilAddress = Address(ipv4: "192.168.10.2:4040")
if let unwrappedAddress = nilAddress {
    print("IPv4: \(unwrappedAddress.ipv4)")
} else {
    print("IPv4: Invalid IP")
}
// IPv4: Invalid IP

func createValidAddress() -> Address {
    let validAddress = Address(ipv4: "192.168.10.2:8080")
    return validAddress!
}

let validAddress = createValidAddress()
print("IPv4: \(validAddress.ipv4)")
// IPv4: 192.168.10.2:8080

let peter = User()
peter.name = "Peter"

peter.address?.ipv4 = validAddress.ipv4
peter.showData()
// name: Peter
// address: Offline
/// Because peter.address? is 'nil', the assignment didnt happend!

print("=============== Calling methods through optional chaining ===============")
peter.connect(from: validAddress)
if let peterAddress = peter.address?.getIPV4() {
    print("address: \(peterAddress)")
} else {
    print("address: Invalid IP")
}
// address: 192.168.10.2:8080

print("=============== Accessing subscripts through optional chaining ===============")
class Logging {
    var server: Server?
}

let mainServer = Server()
mainServer.users.append(peter)
let loggingServer = Logging()
loggingServer.server = mainServer
if let tempUser = loggingServer.server?[0] {
    tempUser.showData()
} else {
    print("No user data on this server")
}
// name: Peter
// address: 192.168.10.2:8080

loggingServer.server = nil
if let tempUser = loggingServer.server?[0] {
    tempUser.showData()
} else {
    print("No user data on this server")
}
// No user data on this server

print("=============== Accessing subscripts of optional type ===============")
let john = User(name: "John", address: Address(ipv4:"192.168.0.5:4040"))
let marry = User(name: "Marry", address: validAddress)
let hacker = User()
hacker.connect(from: Address(ipv4:"278.27.65.123:8080"))
mainServer.users.append(marry)
mainServer.users.append(hacker)
mainServer.users.append(john)

var dictOfUsers = [String: String]()
for user in mainServer.users {
    if let tempName = user.name, let tempAddress = user.address?.getIPV4() {
        dictOfUsers[tempName] = tempAddress
    } else if let tempAddress = user.address?.getIPV4() {
        dictOfUsers["Anonymous"] = tempAddress
    } else if let tempName = user.name {
        dictOfUsers[tempName] = "Offline"
    }
}
for (name, address) in dictOfUsers {
    print("\(name): \(address)")
}
// Peter: 192.168.10.2:8080
// John: Offline
// Anonymous: 278.27.65.123:8080
// Marry: 192.168.10.2:8080

print(dictOfUsers["Peter"]?.hasPrefix("192"))       // Optional(true)
print(dictOfUsers["Anonymous"]?.hasPrefix("192"))   // Optional(false)
print(dictOfUsers["Stephan"]?.hasPrefix("192"))     // nil

print("=============== Linking multiple levels of chaining ===============")
loggingServer.server = mainServer
print(type(of: loggingServer.server?[0].address?.ipv4))     // Optional(String)
print(type(of: validAddress.ipv4))  // String

/// 1st print is linking with multiple levels of chaing so 'ipv4' become Optional(String)
/// 2nd print didn't use any optional chaining so 'ipv4' is still a String

print("=============== Chaining on methods with optional return values ===============")
let stephan = User(name: "Stephan", address: Address(ipv4:"255.289.12.10:8080"))
mainServer.users.append(stephan)
let newInternA = User(name: nil, address: Address(ipv4:"192.169.2.10:8080"))
mainServer.users.append(newInternA)
let newInternB = User(name: nil, address: nil)
mainServer.users.append(newInternB)

for i in 0..<mainServer.userCount {
    if let tempName = loggingServer.server?[i].getName() {
        if let isInOffice = loggingServer.server?[i].getAddress()?.hasPrefix("192.") {
            if isInOffice {
                print("\(tempName) is online and is in the office")
            } else {
                print("\(tempName) is online and is not in the office")
            }
        } else {
            print("\(tempName) is offline")
        }
    } else if let isInOffice = loggingServer.server?[i].getAddress()?.hasPrefix("192.") {
            if isInOffice {
                print("Caution: unregistered person is online and is in the office")
            } else {
                print("Caution: unregistered person is online and is not in the office")
            }
    } else {
        print("Caution: unregistered person is offline")
    }
}
// Peter is online and is in the office                                 --> peter
// Marry is online and is in the office                                 --> marry
// Caution: unregistered person is online and is not in the office      --> hacker
// John is offline                                                      --> john
// Stephan is online and is not in the office                           --> stephan
// Caution: unregistered person is online and is in the office          --> newInternA
// Caution: unregistered person is offline                              --> newInternB

