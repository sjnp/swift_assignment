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

print("=============== Property requirements ===============")
// Error: property in protocol must have explicit { get } or { get set }
// protocol NoNeedForGetOrSet {
//     var someInt: Int
//     var someString: String
// }

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

protocol Protocol1 {
    var someInt: Int { get set }
}
protocol Protocol2 {
    var someProtocol: Protocol1 { get }
}
struct Struct2: Protocol2 {
    class Class1: Protocol1 {
        var someInt: Int = 5
    }

    // candidate has non-matching type 'Struct2.Class1'
    //var someProtocol  = Class1()

    // but this work!
    var someProtocol: Protocol1
}

print("=============== Method requirements ===============")
protocol Togglable {
    static var isOn: Bool { get set }
    static func toggle() -> ()
}

class LightBulb: Togglable {
    var name: String
    static var isOn = false
    static func toggle() { isOn = !isOn }
    init(name: String) { self.name = name }
} 

var leds: [LightBulb] = []
leds.append(LightBulb(name: "LED01"))
leds.append(LightBulb(name: "LED02"))
for led in leds {
    print("\(led.name) \(LightBulb.isOn ? "is on": "is off")")
}
// LED01 is off
// LED02 is off

LightBulb.toggle()

for led in leds {
    print("\(led.name) \(LightBulb.isOn ? "is on": "is off")")
}
// LED01 is on
// LED02 is on

protocol Queueable {
    var nextQueue: Person? { get set }
    func next() -> (Person?)
}
class Person: Queueable {
    var name: String
    var nextQueue: Person? = nil
    func next() -> (Person?) { return nextQueue }
    init(name: String) { self.name = name }
    init(name: String, nextQueue: Person) { 
        self.name = name
        self.nextQueue = nextQueue 
    }
}
let bob = Person(name: "Bob")
let alice = Person(name: "Alice", nextQueue: bob)
print(alice.name)           // Alice
print(alice.next()!.name)   // Bob

print("===============Mutating Method requirements ===============")
protocol Incrementable {
    mutating func increment()
    // do not need to add 'mutating' for mutable structure such as class
}

struct Speaker {
    var soundLevel: Int = 0
    mutating func increment() {
        self.soundLevel += 1
    }
}
var speaker1 = Speaker()
print("Volume: \(speaker1.soundLevel)") // Volume: 0
speaker1.increment()
print("Volume: \(speaker1.soundLevel)") // Volume: 1

print("===============Initializer Requirements===============")
protocol Rollable {
    init(maxRoll: Int)
}
class Dice: Rollable {
    var maxRoll: Int

    // Can only be satisfied by a 'required' initiailizer in non-final class
    //init(maxRoll: Int) { self.maxRoll = maxRoll }

    required init(maxRoll: Int) { self.maxRoll = maxRoll }
}

final class MultidimentionalCoin: Rollable {
    var maxRoll: Int

    // This work because this class is 'final'
    init(maxRoll: Int) { self.maxRoll = maxRoll }
}

print("===============Failable Initializer Requirements===============")
protocol Connectable {
    init? (device: Device)
}

class Device {
    var isOn: Bool = false
    func toggle() { self.isOn = !isOn }
}

class BluetoothDevice: Connectable {
    var signalStrength: Int
    required init? (device: Device) {
        if (!device.isOn) { return nil }
        self.signalStrength = 5
    }
}

let smartphone = Device()
if let headphone = BluetoothDevice(device: smartphone) {
    print("Signal: \(headphone.signalStrength)")
} else {
    print("Device is off")
}
// Device is off

smartphone.toggle()
if let headphone = BluetoothDevice(device: smartphone) {
    print("Signal: \(headphone.signalStrength)")
} else {
    print("Device is off")
}
// Signal: 5

print("===============Protocols as Types===============")
protocol Rejectable {
    func reject() -> ()
}

class Server: Rejectable {
    var isOn = false
    func reject() {
        if (isOn) {
            isOn = !isOn
            print("Connection got rejected")
        } else {
            print("Server is not online")
        }
    }
}

class Network {
    var socket: Rejectable
    init(socket: Rejectable) { self.socket = socket }
    func cutOff() {
        socket.reject()
    }
}

let httpSocket = Server()
let network1 = Network(socket: httpSocket)
network1.cutOff()   // Server is not online
httpSocket.isOn = true
network1.cutOff()   // Connection got rejected

print("===============Delegation===============")
protocol Infectable {
    var population: Int { get }
    var newInfectedCases: Int { get }
    var totalInfectedCases: Int { get }
    func simulate()
}
protocol InfectableDelegate: AnyObject {
    func simulationDidStart(_ dicease: Infectable)
    func simulation(_ dicease: Infectable)
    func simulationDidEnd(_ dicease: Infectable)
}
class Dicease: Infectable {
    var population: Int
    var transmissionRate: Int
    init(population: Int, transmissionRate: Int) { 
        self.population = population 
        self.transmissionRate = transmissionRate
    }

    weak var delegate: InfectableDelegate?

    let initialInfectedCases: Int = 1
    var newInfectedCases: Int = 1
    var totalInfectedCases: Int = 1
    func simulate() {
        delegate?.simulationDidStart(self)
        while(totalInfectedCases < population) {
            newInfectedCases *= transmissionRate
            totalInfectedCases += newInfectedCases
            delegate?.simulation(self)
        }
        delegate?.simulationDidEnd(self)
    }
}
class DiceaseTracker: InfectableDelegate {
    var numberOfDays: Int = 0
    func simulationDidStart(_ dicease: Infectable) {
        print("Day\(numberOfDays): Initial \(dicease.newInfectedCases) case")
    }
    func simulation(_ dicease: Infectable) {
        numberOfDays += 1
        print("Day\(numberOfDays): New Infected \(dicease.newInfectedCases) cases, Total Infected \(dicease.totalInfectedCases) cases")
    }
    func simulationDidEnd(_ dicease: Infectable) {
        print("It takes \(numberOfDays) days to transmit to all of the population")
    }
}

let covidTracker = DiceaseTracker()
let covid = Dicease(population: 60, transmissionRate: 2)
covid.delegate = covidTracker
covid.simulate()
// Day0: Initial 1 case
// Day1: New Infected 2 cases, Total Infected 3 cases
// Day2: New Infected 4 cases, Total Infected 7 cases
// Day3: New Infected 8 cases, Total Infected 15 cases
// Day4: New Infected 16 cases, Total Infected 31 cases
// Day5: New Infected 32 cases, Total Infected 63 cases
// It takes 5 days to transmit to all of the population

print("===============Adding Protocol Conformance with an Extension===============")
protocol DoubleConvertable1 {
    var doubleValue: Double { get }
}
protocol DoubleConvertable2 {
    func convertToDouble() -> (Double)
}

class Item {
    var initialCost: Int = 10
}

extension Item: DoubleConvertable1 {
    var doubleValue: Double {
        return Double(initialCost)
    }
}

extension Item: DoubleConvertable2 {
    func convertToDouble() -> (Double) {
        return Double(initialCost)
    }
}
let item0 = Item()
print(item0.doubleValue) // 10.0
print(item0.convertToDouble()) // 10.0

print("===============Conditionally Conforming to a Protocol===============")
protocol Summable {
    var sum: Double { get }
}
extension Array: Summable where Element: DoubleConvertable1 {
    var sum: Double {
        let doubleArr = self.map { $0.doubleValue }
        return doubleArr.reduce(0, { x, y in
            x + y
        })
    }
}
let item1 = Item()
let items = [item0, item1]
print(items.sum)    // 20.0

print("===============Declaring Protocol Adoption with an extension===============")
class ItemV2 {
    var initialCost: Int = 20
    func convertToDouble() -> (Double) {
        return Double(initialCost)
    }
}
if ItemV2.self is DoubleConvertable2.Type { 
    print("ItemV2 conforms to DoubleConvertable2")
    // ItemV2 conforms to DoubleConvertable2
}
extension ItemV2: DoubleConvertable2 {}

print("===============Adopting a Protocol Using a Synthesized Implementation===============")
struct User: Equatable, Hashable {
    var name: String
    var nameWithUnderscore: String { return "_\(name)"}
    init(name: String) { self.name = name }
}
let alice1 = User(name: "Alice")
let alice2 = User(name: "Alice")
if alice1 == alice2 {
    print("struct User is equatable")
    // struct User is equatable
}
print("alice1's hash value: \(alice1.hashValue)")   // Same hash value as below
print("Alice string hash value: \(alice1.name.hashValue)")  // Same hash value as above

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.name < rhs.name
    }
}
let bob1 = User(name: "Bob")
if bob1 > alice1 {
    print("Bob > Alice")    // Bob > Alice
}
if alice1 <= alice2 {
    print("Alice <= Alice") // Alice <= Alice
}

print("===============Collections of Protocol Types===============")
var doubleItems: [DoubleConvertable1] = [item0, item1]

// Error!: Only concrete types such as structs, enums and classes can conform to protocols
// doubleItems.sum

for item in doubleItems {
    print(item.doubleValue)
}
// 10.0
// 10.0

print("===============Protocol Inheritance===============")
protocol SuperProtocol {
    var superVal: Int { get }
}
protocol SubProtocol: SuperProtocol {
    var subVal: Int { get }
}

// error: 'IntegerStorage' does not conform to protocol 'SuperProtocol'
// struct IntegerStorage: SubProtocol {
//     var subVal: Int = 0
// }

struct IntegerStorage: SubProtocol {
    var superVal: Int = 1
    var subVal: Int = 0
}
let a = IntegerStorage()
print(a.subVal)     // 0
print(a.superVal)   // 1

print("===============Class-Only Protocols===============")
protocol OnlyRefType: AnyObject {
    var objVal: Int { get }
}

// error: non-class type cannot conform to class protocol
// struct ValueType: OnlyRefType {
//     var objVal: Int = 5
// }

class RefType: OnlyRefType {
    var objVal: Int = 10
}
let refType = RefType()
print(refType.objVal)   // 10

print("===============Protocol Composition===============")
// SomeProtocol & AnotherProtocol
protocol Meat {
    var meatType: String { get }
}
protocol Cookable: AnyObject {
    func cook()
}
class Herb: Cookable {
    var herb: String
    init(herb: String) { self.herb = herb }
    func cook() { print("Dried \(self.herb)")}
}
class Food: Meat, Cookable {
    var meatType: String
    init(meatType: String) { self.meatType = meatType }
    func cook() { print("Fried \(self.meatType)")}
}

func seasoning(_ food: Meat & Cookable, with herb: Herb & Cookable) {
    food.cook()
    herb.cook()
}
let friedChicken = Food(meatType: "Chicken")
let pepper = Herb(herb: "Pepper")
seasoning(friedChicken, with: pepper)
// Fried Chicken
// Dried Pepper

print("===============Checking for Protocol Conformance===============")
if !(alice1 is AnyObject.Type) {
    print("Struct cannot conform to 'AnyObject'")
}
// Struct cannot conform to 'AnyObject'

// error: protocol 'Equatable' can only be used as a generic constraint
// because it has Self or associated type requirements
// if let _ = alice1 as? Equatable {
//     print("'User' class conform to 'Equatable' protocol")
// }

if let _ = pepper as? Cookable {
    print("'Herb' class conform to 'Cookable' protocol")
}
// 'Herb' class conform to 'Cookable' protocol

print("===============Optional Protocol Requirements===============")
// optional requirement must be marked with @objc
// @objc protocol Drinkable {
//     @objc optional var isNoSugar: Bool { get }
//     @objc optional var isNoAlcohol: Bool { get }
// }

// class VendingMachine {
//     var item: Drinkable?
//     func describeItems() {
//         var description: String
//         if let isNoSugarDrink = item?.isNoSugar {
//             description = isNoSugarDrink ? "Sugar-free drink" : "Sugary drink"
//         } else if let isNoAlcoholDrink = item?.isNoAlcohol {
//             description = isNoAlcoholDrink ? "Non-Alcoholic drink" : "Alcoholic drink"
//         }
//         if !description.isEmpty {
//             print(description)
//         }
//     }
// }

// error: Objective-C interoperability is disabled 
// This error is about '@objc', which cannot be enabled in swift compiler(Linux)

print("===============Protocol Extensions===============")
extension Hashable {
    func doDoubleHash() -> Int {
        return self.hashValue.hashValue
    }
}

print("\(alice1.name)'s double hash: \(alice1.doDoubleHash())")
// Alice's double hash: ....

print("===============Providing Default Implementations===============")
extension Hashable {
    var doubleHashVal: Int {
        return doDoubleHash()
    }
}

print("\(alice1.name)'s double hash: \(alice1.doubleHashVal)")
// Alice's double hash: ....

print("===============Adding Constraints to Protocol Extensions===============")
extension Array where Element: Hashable {
    func totalHash() -> Int {
        var sum: Int = 0
        for element in self {
            sum += element.hashValue
        }
        return sum
    }
}

let charlie = User(name: "Charlie")
let users = [alice1, bob1, charlie]
print("Total hash: \(users.totalHash())")
// Total hash: .....