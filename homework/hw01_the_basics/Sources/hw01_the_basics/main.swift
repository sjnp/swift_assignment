// HW1: The basics
//=================================================================================================================
// Declare constants
let greetingMessage = "Hello"

// Declare variables
var greetingCount = 0

// Decalre variables with type annotation
var userName: String = "Peter"

//greetingMessage = "Hi"
// Compile error: the value of constants cannot be changed

// Only the value of variables can be changed
userName = "Sarah"
//-----------------------------------------------------------------------------------------------------------------
print("=============== Printing ===============")
// Print with separator and terminator
print(greetingMessage,userName, separator:", ", terminator:"!\n")
greetingCount = greetingCount + 1
//-----------------------------------------------------------------------------------------------------------------
print("=============== Semicolon ===============")
// Use semicolon to write multiple statements in a single line
userName = "Adele"; print(greetingMessage, userName, separator:", ", terminator:"!\n"); greetingCount += 1
//-----------------------------------------------------------------------------------------------------------------
print("=============== Integer ===============")
// Integer
let minUserCount, maxUserCount: UInt8
// Unsigned 8-bit integers: minValue = 0, maxValue = 2^8 - 1 = 255
minUserCount = UInt8.min
maxUserCount = UInt8.max
var userCount: UInt8 = 0
print("Minimum user count: \(minUserCount)")
print("Maximum user count: \(maxUserCount)")
print("Current user count: \(userCount)")
//-----------------------------------------------------------------------------------------------------------------
// Float
let rewardPoint: Double = 12.5
//-----------------------------------------------------------------------------------------------------------------
print("=============== Numeric literals ===============")
// Numeric literals
// Octal number
let maxUserCountInOctal = 0o377
// This will print 255
print("Maximum user count from octal number: \(maxUserCountInOctal)")

// Hexadecimal number with exponential of 2
let rewardPointInHexa = 0x19p-1
// This will be 25 / 2 = 12.5
print("Reward point from octal number: \(rewardPointInHexa)")
//-----------------------------------------------------------------------------------------------------------------
print("=============== Booleans ===============")
// Booleans
var isMale = true

// if-else
if isMale {
	userName = "Peter"
} else {
	userName = "Sarah"
}
print("Hi!, \(userName)")

//-----------------------------------------------------------------------------------------------------------------
// Type safety
//var totalRewardPoint = rewardPoint * userCount
// The above line will not work because of diffent data type ( double * int )

// Type conversion
let someInt = 8
let someFloat = 11.6
let someBool = true
let someString = "one"
let someIntFromFloat = Int(someFloat)
//let someIntFromBool = Int(someBool)
let someIntFromString = Int(someString)
let someFloatFromInt = Float(someInt)
//let someFloatFromBool = Float(someBool)
let someFloatFromString = Float(someString)
//let someBoolFromInt = Bool(someInt)
//let someBoolFromFloat = Bool(someFloat)
let someBoolFromString = Bool(someString)
let someStringFromInt = String(someInt)
let someStringFromFloat = String(someFloat)
let someStringFromBool = String(someBool)
// List of things that can't be conversed : 
// - Bool -> Int
// - Bool -> Float
// - Int -> Bool
// - Float -> Bool

// Type Aliases
typealias UnsignedInt = UInt8
userCount = UnsignedInt.min
//-----------------------------------------------------------------------------------------------------------------
print("=============== Tuples ===============")
// Tuples
var salary: Int
let maleUserDescription = (userName: "Peter", salary: 50_000)
let femaleUserDescription = (userName: "Sarah", salary: 30_000)
let ( maleUserName, maleSalary) = maleUserDescription
if (femaleUserDescription.salary == maleUserDescription.salary) {
	print("\"That's fair\", \(femaleUserDescription.userName) said.")
} else if (femaleUserDescription.1 < maleUserDescription.1) {
	print("\"That's not fair\", \(femaleUserDescription.0) said.")
} else {
	print("\":/\", \(maleUserName) said.")
}
//-----------------------------------------------------------------------------------------------------------------
print("=============== Optional ===============")
// Optionals
// Optional declaration
var hasCar: Bool?
// The default value will be nil
hasCar = true
//print("\(userName) has a car: \(hasCar)")
// Compile error: cant print an optional

// When using type conversion, it can produce optional.
print(someIntFromString)
print(someFloatFromString)
print(someBoolFromString)
// List of type conversions that can produce optional :
// - String -> Int
// - String -> Float
// - String -> Bool

// Force-unwrapping with ! after the variable
//hasCar = nil
print("\(userName) has a car: \(hasCar!)")
// Error compiling will occur if hasCar is nil. The best practice is using if statement first, 
// before force-unwrap an optional variable.
if hasCar != nil {
	print("\(userName) has a car: \(hasCar!)")
} else {
	print("\(userName) has a car: unknown")
}

// Optional binding
if let someNotOptionalInt = someIntFromString {
	// 'someNotOptionalInt' is an Int not an Optional Int
	print("This is not an optional int and its value is \(someNotOptionalInt)")
} else {
	// 'someNotOptionalInt' is not an identifier anymore, so it can't be printed.
	print("This is \(someIntFromString)")
}

print("=============== Implicitly unwrapped optional ===============")
// Implicitly unwrapped optional
// Declaration with '!' instead of '?'
var sex: String! = "Male"
// Compare to default optional
var gender: String? = "Straight"
// Print these optional
// Don't need '!' to unwrap the optional
print("sex: \(String(sex))")
// Need '!' to unwrap the optional
print("gender: \(String(gender!))")

// Declaration of an variable with implicitly unwrapped optional will be default optional
var defaultOptionalSex = sex
//print("\(String(defaultOptionalSex))")
// The above line need '!' to force-unwrap the value inside just like default optional

// *** Implicitly unwrapped optional can be assigned to has 'nil' and it will behave
// like a default optional such as error compiling when type casting 'nil' value
sex = nil
//print("\(String(sex))")
// Have to check before print
if sex != nil {
	print("\(String(sex))")
} else {
	print("This is \'nil\'")
}
// Or use optional binding
if let optionalSex = sex {
	print("\(String(sex))")
} else {
	print("This is \'nil\'")
}
//-----------------------------------------------------------------------------------------------------------------
