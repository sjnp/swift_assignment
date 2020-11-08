// HW2: Basic operators
//=================================================================================================================
// Assignment Operator
// Declare constants
// Float
let averageMaleAge = 22.4
let averageFemaleAge = 23.2
// String
let greetingMessage = "Hello"
let sex = ["Male", "Female"]

// Declare variables
// Integer
var currentMaleCount = 15
var currentFemaleCount = 10
// Array
var maleName = ["Alex", "Bob", "Peter", "John"]
var femaleName = ["Alice", "Hannah", "Sarah"]
// Tuple
var (currentName, currentSex, currentAge) = (maleName[1], sex[0], 24)
//-----------------------------------------------------------------------------------------------------------------
print("=============== Arithmetic Operators ===============")
// Addition
// Can only be used with the same data type
var currentTotalCount = currentFemaleCount + currentMaleCount
var currentTotalMaleAge = Double(currentMaleCount) * averageMaleAge
var currentGreetingMessage = greetingMessage + ", " + femaleName[0]

// Multiplication and division
var currentAverageAge = (currentTotalMaleAge + Double(currentFemaleCount) * averageFemaleAge)/Double(currentTotalCount)
print("Average age = \(currentAverageAge)")

// Overflow operator
var maximumUnsignedInt = UInt8.max
var overflowUnsignedInt = maximumUnsignedInt &+ 1
print("This is an overflow value: \(overflowUnsignedInt)")

// Remainder operator
print("255 % 8 = \(maximumUnsignedInt % 8)")
print("\(Int8.min) % 10 = \(Int8.min % 10)")

// Unary operator
print("Maximum unsigned 8-bit integer is \(-Int(Int8.min)*2-1)")

// Compound Assignment Operator
currentFemaleCount -= 1
currentMaleCount += 1
currentGreetingMessage += "and \(femaleName[1])"

// Comparison Operator
if currentTotalCount > currentMaleCount + currentFemaleCount || currentTotalCount < currentFemaleCount + currentMaleCount {
	print("Counting Error")
}
var newName = "Adele"
if newName < femaleName[0] {
	femaleName[0] = newName
} else if newName > femaleName[2] {
	femaleName[2] = newName
}
print(femaleName)
//-----------------------------------------------------------------------------------------------------------------
print("=============== Ternary Conditional Operators ===============")
// Ternary conditional operator
(maleName[0] < femaleName[0] ? print("Men first!") : print("Women first!"))

//(let exactAge = Int("25")) ? print("Unwrap: \(exactAge)") : print("nil")
// Can't use optional binding with ternary conditional!
//-----------------------------------------------------------------------------------------------------------------
print("=============== Nil-Coalescing Operators ===============")
var optionalGreeting: String?
// Optional with forced-unwrapping
currentGreetingMessage = optionalGreeting != nil ? optionalGreeting! : greetingMessage
print(currentGreetingMessage)
// Implicit unwrapped optional
var implicitOptionalGreeting: String! = "Hi"
currentGreetingMessage = implicitOptionalGreeting ?? greetingMessage
print(currentGreetingMessage)
//-----------------------------------------------------------------------------------------------------------------
print("=============== Range Operators ===============")
// Closed range
for name in maleName[0...3] {
	print(name)
}
// Half-open range
for name in femaleName[0..<3] {
	print(name)
}
// One-sided range
for name in maleName[0...] {
	print(name)
}
for name in femaleName[...2] {
	print(name)
}
//-----------------------------------------------------------------------------------------------------------------
print("=============== Logical Operators ===============")
// Combining logical operator
var currentPersonAge: Int = 20
if((currentPersonAge > 18 && currentPersonAge < 50) || (currentPersonAge > 18 && currentPersonAge < Int(currentAverageAge))) {
	print("You are still young")
}
//-----------------------------------------------------------------------------------------------------------------


