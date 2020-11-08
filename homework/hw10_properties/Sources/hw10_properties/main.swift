// HW10: Properties
//=================================================================================================================
print("=============== Stored Properties ===============")
class PersonWithClass {
    var name : String = "John"
}
struct PersonWithStruct {
    var name : String = "John"
}
var somePersonWithClass = PersonWithClass()
var somePersonWithStruct = PersonWithStruct(name: "Peter")
somePersonWithClass.name = "Bill"
somePersonWithStruct.name = "Bill"
print("class Person: \(somePersonWithClass.name)")      // Bill
print("struct Person: \(somePersonWithStruct.name)")    // Bill

print("=============== Stored Properties of Constant Structure Instances ===============")
let constPersonWithClass = PersonWithClass()
let constPersonWithStruct = PersonWithStruct(name: "Peter")
constPersonWithClass.name = "Bill"
//constPersonWithStruct.name = "Bill"
// Constant Structure Instances's properties cannot be changed!
// Because strucure instances are value type.

print("=============== Lazy Stored Properties ===============")
// *** Lazy properties must be var! ***
struct MobileNumber {
    var region : String  
    var number : String
    lazy var completeNumber = region + number
}
var someMobileNumber = MobileNumber(region: "+66", number: "0831036782")
print(someMobileNumber)                     // completeNumber = nil
print(someMobileNumber.completeNumber)      // +660831036782

print("=============== Computed Properties ===============")
struct Directory {
    let root = "/"
    var dir = "home"
    var completeDir : String {
        get {
            return root + dir
        }
        set (newDir) {
            if newDir[newDir.startIndex] == "/" {
                dir = String(newDir[newDir.index(after: newDir.startIndex)...])
            } else {
                print("Directory must start with '/'")
            }
        }
    }
}
var myDir = Directory()
print(myDir)    // Directory(root: "/", dir: "home")
print(myDir.completeDir)    // /home
print(myDir)    // Directory(root: "/", dir: "home")
myDir.completeDir = "/etc"
print(myDir)    // Directory(root: "/", dir: "etc")
// completeDir is not stored in the instance at all
// ,hence the "computed properties"!

struct shortSetDirectory {
    let root = "/"
    var dir = "home"
    var completeDir : String {
        get {
            return root + dir
        }
        set {
            // newValue is a default reserved word
            if newValue[newValue.startIndex] == "/" {
                dir = String(newValue[newValue.index(after: newValue.startIndex)...])
            } else {
                print("Directory must start with '/'")
            }
        }
    }
}
struct shortSetAndGetDirectory {
    let root = "/"
    var dir = "home"
    var completeDir : String {
        get {
            root + dir
        }
        set {
            // newValue is a default reserved word
            if newValue[newValue.startIndex] == "/" {
                dir = String(newValue[newValue.index(after: newValue.startIndex)...])
            } else {
                print("Directory must start with '/'")
            }
        }
    }
}
struct onlyGetDirectory {
    let root = "/"
    var dir = "home"
    var completeDir : String {
        get {
            root + dir
        }
    }
}
var someDir = onlyGetDirectory()    // Directory(root: "/", dir: "home")
print(someDir.completeDir)          // /home
//someDir.completeDir = "/etc"      This will give an error

print("=============== Property Observer ===============")
struct PayloadInStruct {
    var message : String = "" {
        willSet {
            print("Sending \"\(newValue)\"...")
        }
        didSet {
            print("\"\(message)\" is sent")
        }
    }
}
class PayloadInClass {
    var message : String = "" {
        willSet {
            print("Sending \"\(newValue)\"...")
        }
        didSet {
            print("\"\(message)\" is sent")
        }
    }
    func addQuestionMark() {
        self.message.append("?")
    }
}
var structPayload = PayloadInStruct(message: "Hello!")
structPayload.message = "Hi!"
// Sending "Hi!"...
// "Hi!" is sent

let classPayload = PayloadInClass()
classPayload.message = "Howdy!"
// Sending "Howdy!"...
// "Howdy!" is sent
// Initializer in struct and class does not trigger property observer!

classPayload.addQuestionMark()
// Sending "Howdy!?"...
// "Howdy!?" is sent

print("=============== Property Wrappers ===============")
@propertyWrapper
class LimitedListOfString {
    private var textList: [String] = []
    // wrappedValue is a reserved word for property wrappers
    var wrappedValue: Array<String> {
        get { return textList }
        set {
            if newValue.count > 10 {
                textList = Array(newValue[..<10])
            } else {
                textList = newValue
            }
        }
    }
}
class Receiver {
    @LimitedListOfString var receivedText: Array<String> {
        willSet {
            print("Receiving Message...")
        }
        didSet {
            print("Message Received!...")
        }
    }
}

var greetingList = ["Hi", "Hello", "Howdy"]
var someReceiver = Receiver()
print(someReceiver.receivedText)        // []
someReceiver.receivedText = greetingList
// Receiving Message
// Message Received
print(someReceiver.receivedText)        // [Hi, Hello, Howdy]

class anotherReceiver {
    // explicitly wraps without @LimitedListOfString
    private var _receivedText = LimitedListOfString()
    var receivedText: Array<String> {
        get { return _receivedText.wrappedValue }
        set { _receivedText.wrappedValue = newValue }
        // cannot use willSet/didSet with getter/setter
    }
}
print("=============== Setting Initial Values for Wrapped Properties ===============")
@propertyWrapper
class LimitedList {
    private var maximumCount: Int
    private var intList: [Int]

    var wrappedValue: Array<Int> {
        get { return intList }
        set {
            if newValue.count > maximumCount {
                intList = Array(newValue[..<maximumCount])
            } else {
                intList = newValue
            }
        }
    }

    init() {
        maximumCount = 10
        intList = []
    }
    init(wrappedValue: [Int]) {
        maximumCount = 10
        if wrappedValue.count > maximumCount {
            intList = Array(wrappedValue[..<maximumCount])
        } else {
            intList = wrappedValue
        }
    }
    init(wrappedValue: [Int], maximumCount: Int) {
        self.maximumCount = maximumCount
        if wrappedValue.count > maximumCount {
            intList = Array(wrappedValue[..<maximumCount])
        } else {
            intList = wrappedValue
        }
    }
}

class EmptyPoints {
    @LimitedList var points: [Int]
}
var emptyPoints = EmptyPoints()
print(emptyPoints.points)       // []

class DefaultPoints {
    @LimitedList var points: [Int] = [23, 14, 6]
}
var defaultPoints = DefaultPoints()
print(defaultPoints.points)     // [23, 14, 6]

class DefaultPointsAndMax {
    @LimitedList(wrappedValue: [23, 14, 6], maximumCount: 12) var points: [Int]
    // or
    // @LimitedList(maximumCount: 12) var points: [Int] = [23, 14, 6]
}
var defaultPointsAndMax = DefaultPointsAndMax()
print(defaultPointsAndMax.points)       // [23, 14, 6]

print("=============== Projecting a Value From a Property Wrapper ===============")
@propertyWrapper
struct OptionalInt {
    private var optionalInt: Int?
    // projectedValue is a reserved word
    var projectedValue: Int
    init() {
        optionalInt = Int("0")
        projectedValue = optionalInt!
    }
    var wrappedValue: Int? {
        get { return optionalInt }
        set {
            if let actualInt = newValue {
                optionalInt = newValue
                projectedValue = actualInt
            } else {
                projectedValue = 0
            }
        }
    }
}
class IntString {
    @OptionalInt var intFromString: Int?

    func update() {
        // use $intFromString to access projectedValue
        if intFromString! == $intFromString {
            print("Nothing to update value: \($intFromString)")
        } else {
            intFromString = Int(String($intFromString))
            print("Updated value: \($intFromString)")
        }
    }
}
var someIntString = IntString()
someIntString.update()      // Nothing to update value: 0
someIntString.intFromString = Int("14")
someIntString.update()      // Nothing to update value: 14
someIntString.intFromString = Int("?")
print("Error! must reset value to \(someIntString.$intFromString)")     // Error! must reset value to 0
someIntString.update()      // Updated value: 0

print("=============== Type Properties ===============")
class DiceRoll {
    static var storedRoll = 0
    // lazy static var storedRoll = 0 will give an error
    // static is an already-lazy global
    static var computedRoll: Int {
        if storedRoll < 6 {
            storedRoll = storedRoll + 1
            return storedRoll
        } else {
            storedRoll = 0
            return storedRoll
        }
    }
    var currentRoll: Int = 0 {
        willSet {
            print("Rolling...", terminator: "")
        }
        didSet {
            if DiceRoll.storedRoll == 0 {
                print("Reset roll")
            } else {
                print("Updated roll")
            }
        }
    }
    func roll() {
        // storedRoll & computedRoll are static members
        // must use DiceRoll.storedRoll & DiceRoll.computedRoll
        print(DiceRoll.storedRoll, "->", DiceRoll.computedRoll)
        currentRoll = DiceRoll.storedRoll
    }
}
let firstPlayer = DiceRoll()
firstPlayer.roll()
// 0 -> 1
// Rolling...Updated roll

let secondPlayer = DiceRoll()
secondPlayer.roll()
// 1 -> 2
// Rolling...Updated roll

print("1st player roll: \(firstPlayer.currentRoll)")    // 1st player roll: 1
print("2nd player roll: \(secondPlayer.currentRoll)")   // 2nd player roll: 2
