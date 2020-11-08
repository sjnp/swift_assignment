/**
    # Password Generator

    - Forbidden word list
    - How many chars?
    - Satisfied?
*/
import Foundation

func addBannedString() -> (String) -> Set<String> {
    var bannedWords = Set<String>()
    func add(_ bannedString: String) -> Set<String> {
        bannedWords.insert(bannedString)
        return bannedWords
    }
    return add
}

func checkValidity(of input: String?, with charList: Array<String>) -> Bool {
    var isValid = true
    if let unwrappedInput = input {
        for char in unwrappedInput {
            isValid = charList.contains(String(char))
            if isValid == false {
                break
            }
        }
    } else {
        return false
    }
    
    return isValid
}

func generatePassword(digits: Int, from characters: Array<String>, without bannedWords: Set<String>) -> String {
    let randomNumber = { (limit: Int) -> Int in Int.random(in: 0..<limit)}
    var password = ""
    var isValid = false
    while(!isValid) {
        for _ in 0..<digits {
            password += characters[randomNumber(characters.count)]
        }
        for bannedWord in bannedWords {
            if password.contains(bannedWord) == false {
                isValid = true
            } else {
                break
            }
        }
    }
    return password
}

/// Setup some constants
enum Strength: String {
    /// Password with digits
    case low

    /// Password with digits and lowercase alphabets
    case medium

    /// Password with digits, lowercase and uppercase alphabets
    case high
}

let upperCaseRange = UInt8(ascii: "A")...UInt8(ascii: "Z")
let lowerCaseRange = UInt8(ascii: "a")...UInt8(ascii: "z")
let digitRange = UInt8(ascii: "0")...UInt8(ascii: "9")
let digits = digitRange.map {String(Character(UnicodeScalar($0)))}
let lowerCases = lowerCaseRange.map {String(Character(UnicodeScalar($0)))}
let upperCases = upperCaseRange.map {String(Character(UnicodeScalar($0)))}
let allChars = digits + lowerCases + upperCases


var bannedDigits = Set<String>()
var bannedLowerCases = Set<String>()
var bannedStrings = Set<String>()

let appendToBannedDigits = addBannedString()
let appendToBannedLowerCases = addBannedString()
let appendToBannedStrings = addBannedString()

/// Add banned word
var isDoneSettingBannedWord = false
let printInvalidInputMessage = { print("*** Invalid input, please try again... ***") }

while(!isDoneSettingBannedWord) {
    print("1. Add banned digits")
    print("2. Add banned lowercase word")
    print("3. Add banned any string")
    print("Pick 1 - 3 or 0 to finish setting up banned word: ", terminator:"")
    let input = readLine()
    switch input {
    case "0":
        isDoneSettingBannedWord = true

    case "1":
        print("Add banned digits: ", terminator:"")
        let inputDigits = readLine()
        if checkValidity(of: inputDigits, with: digits) {
            bannedDigits = bannedDigits.union(appendToBannedDigits(inputDigits!))
        } else {
            printInvalidInputMessage()
        }

    case "2":
        print("Add banned lowercase word: ", terminator:"")
        let inputLowerCases = readLine()
        if checkValidity(of: inputLowerCases, with: lowerCases) {
            bannedLowerCases = bannedLowerCases.union(appendToBannedLowerCases(inputLowerCases!))
        } else {
            printInvalidInputMessage() 
        }

    case "3":
        print("Add banned string: ", terminator:"")
        let inputString = readLine()
        if checkValidity(of: inputString, with: allChars) {
            bannedStrings = bannedStrings.union(appendToBannedStrings(inputString!))
        } else {
            printInvalidInputMessage()
        }
            
    default:
        printInvalidInputMessage()
    }
}

bannedStrings = bannedStrings.union(bannedLowerCases.union(bannedDigits))

let printBannedSet = { (bannedSet: Set<String>) -> () in
    print(bannedSet)
}

print("Banned digits set: ", terminator:"")
printBannedSet(bannedDigits)
print("Banned lowercase word set: ", terminator:"")
printBannedSet(bannedLowerCases)
print("Banned string set: ", terminator: "")
printBannedSet(bannedStrings)

var isDone = false
var passwords = [String: String]()
while(!isDone) {
    print("Input Password Length (8 - 20): ", terminator:"")
    if let passwordLength = readLine() {
        if let length = Int(passwordLength) {
            if length > 7 && length < 21 {
                passwords[Strength.low.rawValue] = generatePassword(digits: length, from: digits, without: bannedDigits)
                passwords[Strength.medium.rawValue] = generatePassword(digits: length, from: lowerCases, without: bannedLowerCases)
                passwords[Strength.high.rawValue] = generatePassword(digits: length, from: allChars, without: bannedStrings)
                isDone = true
            } else {
                printInvalidInputMessage()
            }
        } else {
            printInvalidInputMessage()
        }
    } else {
        printInvalidInputMessage()
    }
}

for (passwordStrength, password) in passwords {
    print("\(passwordStrength) strength password: \(password)")
}