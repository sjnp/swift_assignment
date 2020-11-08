// HW6: Functions 
//=================================================================================================================
print("=============== Defining and Calling Functions ===============")
func convertToSet(someString: String) -> Set<Character> {
    var setFromString = Set<Character>()
    for char in someString {
        setFromString.insert(char)
    }
    return setFromString
}
print(convertToSet(someString: "This is a test."))

print("=============== Functions Without Parameters ===============")
func getStringOptional() -> String? {
    return String("Hallo, ich habe eine Zeitung.")
}
print(getStringOptional()!)

print("=============== Functions With Multiple Parameters ===============")
func findIntersect(someString: String, someStringOptional: String?) -> Set<Character> {
    var setFromString = Set<Character>()
    var setFromStringOptional = Set<Character>()
    for char in someString {
        setFromString.insert(char)
    }
    if let actualString = someStringOptional {
        for char in actualString {
            setFromStringOptional.insert(char)
        }
    }
    return setFromString.intersection(setFromStringOptional)
}
print(findIntersect(someString: "Danke", someStringOptional: getStringOptional()))

print("=============== Functions Without Return Values ===============")
func showStringOptional(stringOptional: String?) {
    if let actualString = stringOptional {
        print("\(type(of: stringOptional)) : \(actualString)")
    } else {
        print("This string optional is nil")
    }
}
showStringOptional(stringOptional: getStringOptional())

print("=============== Functions With Multiple Return Values ===============")
func getStringOptionalDetails(stringOptional: String?) -> (stringCount: Int, actualString: String) {
    var actualString: String
    if stringOptional != nil {
        actualString = stringOptional!
    } else {
        actualString = ""
    }
    return (actualString.count, actualString)
}
let stringDetailsTuple = getStringOptionalDetails(stringOptional: getStringOptional())
print("'\(stringDetailsTuple.1)' have \(stringDetailsTuple.0) characters")

print("=============== Functions With Optional Tuple Return Types ===============")
func getOptionalTuple(someOptionalString: String?) -> (actualString: String, stringCount: Int)? {
    if someOptionalString == nil {
        return nil
    } else {
        return (someOptionalString!, someOptionalString!.count)
    }
}
if let optionalTuple = getOptionalTuple(someOptionalString: "Danke") {
    print("'\(optionalTuple.0)' have \(optionalTuple.1) characters")
} else {
    print("This is nil optional")
}

print("=============== Functions With an Implicit Return ===============")
func doubleSum(firstDouble: Double, secondDouble: Double) -> Double {
    firstDouble + secondDouble
}
print("10.5 + 0.7 =", doubleSum(firstDouble: 10.5, secondDouble: 0.7))

print("=============== Specifying Argument Labels ===============")
func calculateGPA(of student: String, from points: Int) -> (String, Character) {
    if points > 50 {
        return (student, "A")
    } else if points > 20 {
        return (student, "C")
    } else {
        return (student, "F")
    }
}
let studentWithGrade = calculateGPA(of: "Peter", from: 60)
print("\(studentWithGrade.0) got \(studentWithGrade.1)")

print("=============== Omitting Argument Labels ===============")
func verifyTransaction(_ bankAccount: String, hasPaid: Bool) {
    if hasPaid {
        print("\(bankAccount) is verified")
    } else {
        print("\(bankAccount) is not verified")
    }
}
verifyTransaction("SJNP-50892", hasPaid: true)

print("=============== Default Parameter Values ===============")
func donateRequest(from bankAccount: String, cost: Int = 15) {
    if cost == 15 {
        print("\(bankAccount) has donated with minimum cost.") 
    } else if cost < 15 {
        print("\(bankAccount) has to donate at minimum cost 15$")
    } else {
        print("\(bankAccount) has donated with \(cost)$")
    }
}
donateRequest(from: "SJ-979798")

print("=============== Variadic Parameters ===============")
func setPassword(password: Character...) -> Bool {
    var totalChars = 0
    var isAccepted: Bool = false
    for _ in password {
        totalChars += 1
    }
    if totalChars < 8 {
        print("Your password must have at least 8 characters")
        isAccepted = false
    } else if totalChars < 16 {
        print("Your password is quite weak")
        isAccepted = true
    } else if totalChars >= 16 {
        print("Your password is strong!")
        isAccepted = true
    }
    return isAccepted
}
if setPassword(password: "i", "P", "2", "0", "9") {
    print("Password is accepted")
} else {
    print("Password is not accepted")
}

print("=============== In-Out Parameters ===============")
func updateAccount(bankAccount: String, _ bonusPoint: inout Double) {
    bonusPoint *= 1.2
    print("\(bankAccount): updated")
}
var someBonusPoint: Double = 500
updateAccount(bankAccount: "SJ-7829749", &someBonusPoint)
print("Lastest bonus points:", someBonusPoint)

print("=============== Function Types ===============")
func intersectTwoSets(_ firstSet: Set<Int>, _ secondSet: Set<Int>) -> Set<Int> {
    return firstSet.intersection(secondSet)
}
func unionTwoSets(_ firstSet: Set<Int>, _ secondSet: Set<Int>) -> Set<Int> {
    return firstSet.union(secondSet)
}

var setA: Set<Int> = [1, 4, 5, 2, 10, 8, 7]
var setB: Set<Int> = [2, 3, 5, 9, 11, 6, 12]
var setOperation: (Set<Int>, Set<Int>) -> Set<Int> = intersectTwoSets
print("A intersect B: \(setOperation(setA, setB))")
setOperation = unionTwoSets
print("A union B: \(setOperation(setA, setB))")

print("=============== Function Types as Parameter Types ===============")
var setC: Set<Int> = [2, 6, 9, 12]
func subtractAfterSetOperation(_ setOperation: (Set<Int>, Set<Int>) -> Set<Int>, _ firstSet: Set<Int>, _ secondSet: Set<Int>, _ thirdSet: Set<Int>) -> Set<Int> {
    return setOperation(firstSet, secondSet).subtracting(thirdSet)
}
print("A union B then subtract C: \(subtractAfterSetOperation(setOperation,setA, setB, setC))")

print("=============== Function Types as Return Types ===============")
func intersectAfterSetOperation() -> (Set<Int>, Set<Int>) -> Set<Int> {
    return intersectTwoSets
}
let callToIntersectFunc = intersectAfterSetOperation()
print("A union B then intersect C:", callToIntersectFunc(setOperation(setA, setB), setC))

print("=============== Nested Function ===============")
/*
func intersectAfterIntersect(_ firstSet: Set<Int>, _ secondSet: Set<Int>, _ thirdSet: Set<Int>) -> Set<Int> {
    func intersectWith(_ firstSet: Set<Int>, _ secondSet: Set<Int>) -> Set<Int> {
        return firstSet.intersection(secondSet)
    }
    return intersectWith(intersectWith(firstSet, secondSet), thirdSet)
}
print("A intersect B then intersect C:", intersectAfterIntersect(setA, setB, setC))
*/
func intersectAfterIntersect(_ firstSet: Set<Int>, _ secondSet: Set<Int>, _ thirdSet: Set<Int>) -> (Set<Int>, Set<Int>, Set<Int>) -> Set<Int> {
    func intersectWith(_ firstSet: Set<Int>, _ secondSet: Set<Int>, _ thirdSet: Set<Int>) -> Set<Int> {
        return firstSet.intersection(secondSet).intersection(thirdSet)
    }
    return intersectWith
}
print("A intersect B then intersect C:", intersectAfterIntersect(setA, setB, setC)(setA, setB, setC))
