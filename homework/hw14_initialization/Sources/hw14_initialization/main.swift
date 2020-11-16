// HW14: Initialization
//=================================================================================================================
print("=============== Setting Initial Values for Stored Properties ===============")
class Date {
    var day: UInt
    var month: String
    var year: UInt
    init() {
        day = 1
        month = "January"
        year = 1999
        print(day, month, year)
    }
}
let someDate = Date()
// 1 January 1999

print("=============== Initialization Parameters ===============")
struct Price {
    var priceInBaht: Double
    init(fromYen yen: Double) { priceInBaht = yen * 0.29 }
    init(fromWon won: Double) { priceInBaht = won * 0.027 }
}
let jpPrice = Price(fromYen: 4000)
print("\(jpPrice.priceInBaht) Baht")    // 1160.0 Baht
let krPrice = Price(fromWon: 40000)     
print("\(krPrice.priceInBaht) Baht")    // 1080.0 Baht

print("=============== Parameter Names and Argument Labels ===============")
class Room {
    let window: UInt
    let door: UInt
    init() {
        window = 2
        door = 1
    }
    init(window: UInt, door: UInt) {
        self.window = window
        self.door = door
    }
    init(_ window: UInt, _ door: UInt) {
        self.window = window
        self.door = door
    }
    init(withSymmetry sym: UInt) {
        window = sym
        door = sym
    }
    func show() { print("window: \(window), door: \(door)") }
}
let defaultRoom = Room()
defaultRoom.show()      // window: 2, door: 1
let someRoom = Room(window: 3, door: 1)
someRoom.show()         // window: 3, door: 1
let anyRoom = Room(4, 2)
anyRoom.show()          // window: 4, door: 2
let symmetryRoom = Room(withSymmetry: 2)
symmetryRoom.show()     // window: 2, door: 2

print("=============== Optional Property Types ===============")
class Person {
    // This must be "var"
    var name: String?
    func getNameStatus() {
        if let unwrappedName = name {
            print(unwrappedName)
        } else {
            print("undefined name")
        }
    }
}
let somePerson = Person()
somePerson.getNameStatus()  // undefined name
somePerson.name = "Peter"
somePerson.getNameStatus()  // Peter

print("=============== Assigning Constant Properties During Initialization ===============")
class Text {
    let key: String
    init(key: String) {
        self.key = key
        print("This key is constant")
    }
}
let someText = Text(key: "asdf1234")    // This key is constant

print("=============== Default Initializers ===============")
/// Class without init
class SomeClass {
    var someInt: Int = 0 
    var someString: String?
}

/// Struct with default memberwise init
struct SomeStruct {
    var someInt: Int = 0
    var someString: String?
}
let someStruct = SomeStruct(someInt: 5, someString: "five")

print("=============== Initializer Delegation for Value Types ===============")
struct Greeting {
    var greet = "Hello"
}
struct User {
    var name = "John"
}
struct GreetingMessage {
    var user = User()
    var greeting = Greeting()
    init() { }
    init(name: String) {
        self.user = User(name: name)
    }
    init(name: String, greet: String) {
            self.init(name: name)
            greeting = Greeting(greet: greet)
    }
    func greet() {
        print(greeting.greet, user.name)
    }
}
let greetingMessage1 = GreetingMessage()
greetingMessage1.greet()    // Hello John
let greetingMessage2 = GreetingMessage(name: "Peter")
greetingMessage2.greet()    // Hello Peter
let greetingMessage3 = GreetingMessage(name: "Peter", greet: "Hi")
greetingMessage3.greet()    // Hi Peter

print("=============== Designated Initializers and Convenience Initializers ===============")
class Page {
    var header: String
    /// This is designated init
    init(header: String) {
        print("Designated init of Page class is called")
        self.header = header
    }
    /// This is convenience init
    /// A convenience init must call another init from the same class
    /// A convenience init must ultimately call a designated init
    convenience init() {
        print("Convenience init of Page class is called")
        self.init(header: "NULL")
    }
}
let somePage = Page()
// Convenience init of Page class is called
// Designated init of Page class is called

print("=============== Initializer Inheritance ===============")
class Content : Page {
    var paragraph: String
    init(paragraph: String) {
        print("Designated init of Content class is called")

        /// This must be before init of super class
        self.paragraph = paragraph

        /// Must call super class's init
        /// That is not a convenience init
        super.init(header: "")
    }
    convenience init() {
        print("Convenience init of Content class is called")
        self.init(paragraph: "NULL")
    }
}
let someContent = Content()
/// Convenience init of Content class is called
/// Designated init of Content class is called
/// Designated init of Page class is called

print("=============== Initializer Overriding===============")
class Customer {
    var email: String 
    init() {
        print("Designated init() of Customer class is called")
        email = "null@ru.ac.th"
    }
}
class SpecialCustomer: Customer {
    var promo: Bool
    init(promotion: Bool) {
        print("Designated init of SpecialCustomer class is called")
        promo = promotion 

        /// super.init() is implicitly called
    }

    /// Must have override
    /// Because super class has the same init()
    convenience override init() {
        print("Covenience init() of SpecialCustomer class is called")
        self.init(promotion: true)
    }

}
let someSpecialCustomer = SpecialCustomer()
/// Covenience init() of SpecialCustomer class is called
/// Designated init of SpecialCustomer class is called
/// Designated init() of Customer class is called

print("=============== Automatic Initializer Inheritance ===============")
class GreetingCustomer: Customer {
    /// init of super class will be inherited automatically
    /// Because this class have no designated init
    var greetingMessage: String { "Hello + \(super.email)" }
}
let someGreetingCustomer = GreetingCustomer()
/// Designated init() of Customer class is called

print("----------")

class GreetingSpecialCustomer: SpecialCustomer {
    /// init/convenience init of super will be inherited as well
    func show() { print("Hello!, \(super.email)") }
}
let someGreetingSpecialCustomer = GreetingSpecialCustomer()
/// Covenience init() of SpecialCustomer class is called
/// Designated init of SpecialCustomer class is called
/// Designated init() of Customer class is called

print("----------")

class DiscountedRate: SpecialCustomer {
    var rate: UInt
    init(promotion: Bool, rate: UInt) {
        print("Designated init of DiscountedRate class is called")
        if promotion {
            self.rate = rate
        } else {
            self.rate = 0
        }
        super.init(promotion: promotion)
    }
    override convenience init(promotion: Bool) {
        print("Convenience init of DiscountedRate class is called")
            self.init(promotion: promotion, rate: 15)
    }
    /// There will be conveniene init() which is inherited from super class automatically!
}


let someDiscountedRate = DiscountedRate()
/*
This instances will call
1. convenience init() of SpecialCustomer class because it is inherited automatically
2. self.init(promotion: Bool) of 1. is called
3. It refers to convenience init(promotion: Bool) of DiscountedRate class
4. Designated init is called from self.init(promotion: promotion, rate: 15) 
5. After assigned the stored value of DiscountedRate class the init of super class is called
*/
/// Covenience init() of SpecialCustomer class is called
/// Convenience init of DiscountedRate class is called
/// Designated init of DiscountedRate class is called
/// Designated init of SpecialCustomer class is called
/// Designated init() of Customer class is called
print("----------")

let anyDiscountedRate = DiscountedRate(promotion: false)
/// Convenience init of DiscountedRate class is called
/// Designated init of DiscountedRate class is called
/// Designated init of SpecialCustomer class is called
/// Designated init() of Customer class is called

print("=============== Failable Initializers ===============")
class UnsignedIntFromString {
    let number: String
    init?(number: String) {
        if UInt(number) != nil {
            self.number = number
        } else {
            return nil
        }
    }
}

let two = UnsignedIntFromString(number: "02")
print(type(of: two))        /// Optional<UnsignedIntFromString>
if let unsignedInt = two {
    print("This string can be converted into \(UInt(unsignedInt.number))")
}
/// This String can be converted into 2

let minusOne = UnsignedIntFromString(number: "-1")
if let unsignedInt = minusOne {
    print("This string can be converted into \(UInt(unsignedInt.number))")
} else {
    print("This string can't be converted into UInt")
}
/// This string can't be converted into UInt

print("=============== Failable Initialzers for Enumerations ===============")
enum Vowel {
    case a, e, i, o, u
    init?(char: Character) {
        switch char {
        case "a", "A":
            self = .a
        case "e", "E":
            self = .e
        case "i", "I":
            self = .i
        case "o", "O":
            self = .o
        case "u", "U":
            self = .u
        default:
            return nil
        }
    }
}

if let engChar = Vowel(char: "A") {
    print("Vowel \(engChar)")   
}
/// Vowel a

if let engChar = Vowel(char: "B") {
    print("Vowel \(engChar)")
} else {
    print("This char is not vowel")
}
/// This char is not vowel

print("=============== Failable Initializers for Enumerations with Raw Values ===============")
enum DiceRoll: Int {
    case one = 1, two, three, four, five, six
}

func checkRoll(value: Int) {
    /// DiceRoll(rawValue: value) is optional of DiceRoll
    if let roll = DiceRoll(rawValue: value) {
        print("\(roll) is valid for dice rolling")
    } else {
        print("This value is invalid for dice rolling")
    }
}
checkRoll(value: 6)    /// six is valid for dice rolling
checkRoll(value: 7)    /// This value is invalid for dice rolling

print("=============== Propagation of Initialization Failure ===============")
class Message {
    var text: String
    init?(text: String) {
        print("Designated init of Message class is called")
        if text.count > 10 { return nil }
        self.text = text
    }
    convenience init?() {
        print("Convenience init of Message class is called")
        self.init(text: "...")
    }
}

class BotMessage: Message {
    var repeatCount: UInt 
    init?(repeatCount: UInt, text: String) {
        print("Designated init of BotMessage class is called")
        if repeatCount > 10 { return nil }
        self.repeatCount = repeatCount
        super.init(text: text)
    }
    override convenience init?(text: String) {
        print("Convenience init of BotMessage class is called")
        self.init(repeatCount: 10, text: text)
    }
}
if let failedBotMessage1 = BotMessage(repeatCount: 11, text: "Hey!") {
    print("Passed!:", failedBotMessage1)
} else {
    print("Failed!")
}
/// Designated init of BotMessage class is called
/// Failed
print("----------")

if let failedBotMessage2 = BotMessage(repeatCount: 5, text: "This text is more than 10 chars!") {
    print("Passed!:", failedBotMessage2)
} else { 
    print("Failed!")
}
/// Designated init of BotMessage class is called
/// Designated init of Message class is called
/// Failed!
print("----------")

if let passedBotMessage = BotMessage(text: "Pass!") {
    print("Passed!:", passedBotMessage.text)
} else {
    print("Failed!")
}
/// Convenience init of BotMessage class is called
/// Designated init of BotMessage class is called
/// Designated init of Message class is called
/// Passed!: Pass!

print("=============== Overriding a Failable Initializer ===============")
class ValidMessage: Message {
    override init(text: String) {
        let newText: String
        if text.count > 10 {
            let index = text.index(text.startIndex, offsetBy: 10)
            newText = String(text[..<index])
        } else {
            newText = text
        }
        (super.init(text: newText))!
    }
}
let someValidMessage = ValidMessage(text: "More Than Ten")
/// Designated init of Message class is called
print(someValidMessage.text)
/// More Than

print("=============== Required Initializers ===============")
class Book {
    var pageCount: UInt
    required init(pageCount: UInt) {
        self.pageCount = pageCount
    }
    required convenience init() {
        self.init(pageCount: 20)
    }
}

class Magazine: Book {
    required init(pageCount: UInt) {
        super.init(pageCount: pageCount + 10)
    }
    required convenience init() {
        self.init(pageCount: 30)
    }
}

print("=============== Setting a Default Property Value with a Closure or Function ===============")
class Sequence {
    let list: [Int] = {
        var tempList = [Int]()
        let max = 20 
        for i in 0..<max {
            if i == 0 || i == 1 {
                tempList.append(i)
            } else {
                tempList.append(tempList[i-1] + tempList[i-2])
            }
        }
        print(tempList)
        return tempList
    }()
    func isOdd(at index: Int) -> Bool {
        return list[index]%2 == 1 ? true: false
    }
}
let someSequence = Sequence()
print(someSequence.isOdd(at: 5))