// HW5: Control Flow
//=================================================================================================================
print("=============== For-In Loops ===============")
var germanVocab = [String: [String]]()
germanVocab["der"] = ["Mann", "Junge", "Apfel"]
germanVocab["die"] = ["Frau", "Zeitung", "Katze"]
germanVocab["das"] = ["Kind", "Buch", "Wasser"]
for (gender, words) in germanVocab {
    for word in words {
        print(gender, word, terminator: ", ")
    }
    print("")
}
var germanVocabCount = 0
for (_, words) in germanVocab {
    for _ in words {
        germanVocabCount += 1
    }
}
print("There are \(germanVocabCount) words")
var germanVocabArr = [String]()
for words in germanVocab.values {
    for word in words {
        germanVocabArr.append(word)
    }
}
for index in 0..<germanVocabCount {
    print(germanVocabArr[index], terminator: " ")
}
print("")
print("=============== Stride ===============")
var openedRangeOddNumbers = [Int]()
var closedRangeOddNumbers = [Int]()
for num in stride(from: 1, to: 15, by: 2) {
    openedRangeOddNumbers.append(num)
}
for num in stride(from: 1, through: 15, by: 2) {
    closedRangeOddNumbers.append(num)
}
print("stride to 15:\t\t\(openedRangeOddNumbers)")
print("stride through 15:\t\(closedRangeOddNumbers)")

print("=============== While ===============")
let flagtorialNumber = 10
var flagtorialSum = 1
var flagtorialIndex = flagtorialNumber
while flagtorialIndex > 0 {
    flagtorialSum *= flagtorialIndex
    flagtorialIndex -= 1
}
print("\(flagtorialNumber)! = \(flagtorialSum)")

print("=============== Repeat-While ===============")
flagtorialIndex = flagtorialNumber
flagtorialSum = 1
repeat {
    flagtorialSum *= flagtorialIndex
    flagtorialIndex -= 1
} while flagtorialIndex > 0
print("\(flagtorialNumber)! = \(flagtorialSum)")

print("=============== If ===============")
for (gender, words) in germanVocab {
    for word in words {
        if gender == "der" {
            print("\(word): Masculine")
        } else if gender == "die" {
            print("\(word): Feminine")
        } else {
            print("\(word): Neuter")
        }
    }
}

print("=============== Switch ===============")
let randomCharacter = "C"
switch randomCharacter {
    case "A", "a":
        print("Apfel")
    case "B", "b":
        print("Buch")
    case "F", "f":
        print("Frau")
    case "J", "j":
        print("Junge")
    case "K", "k":
        print("Katze")
        print("Kind")
    case "M", "m":
        print("Mann")
    case "W", "w":
        print("Wasser")
    case "Z", "z":
        print("Zeitung")
    default:
        print("No reserved vocab found for '\(randomCharacter)'")
}
switch randomCharacter {
    case "A"..."F", "a"..."f":
        print("Apfel")
        print("Buch")
        print("Frau")
    case "G"..."P", "g"..."p":
        print("Junge")
        print("Katze")
        print("Kind")
        print("Mann")
    case "Q"..."Z", "q"..."z":
        print("Wasser")
        print("Zeitung")
    default:
        print("No reserved vocab found for '\(randomCharacter)'")
}

print("=============== Tuples in Switch ===============")
let randomWordTuple = ("der", "Hund")
switch randomWordTuple {
    case ("der", "Apfel"):
        print("\(randomWordTuple) => The apple")
    case ("der", "Junge"):
        print("\(randomWordTuple) => The boy")
    case ("der", "Mann"):
        print("\(randomWordTuple) => The man")
    case ("der", _):
        print("\(randomWordTuple) => Masculine noun : unknown meaning")
    default:
        print("\(randomWordTuple) => Unknown word")
}
switch randomWordTuple {
    case ("der", "Apfel"):
        print("\(randomWordTuple) => The apple")
    case ("der", "Junge"):
        print("\(randomWordTuple) => The boy")
    case ("der", "Mann"):
        print("\(randomWordTuple) => The man")
    case ("der", _):
        print("\(randomWordTuple) => Masculine noun : unknown meaning")
    default:
        print("\(randomWordTuple) => Unknown word")
}
switch randomWordTuple {
    case ("der", let noun):
        print("\(noun) => Masculine noun")
    case ("die", let noun):
        print("\(noun) => Feminine noun")
    case ("das", let noun):
        print("\(noun) => Neuter noun")
    default:
        print("\(randomWordTuple) => Unknown word")
}

print("=============== Where in Switch ===============")
switch randomWordTuple {
    case let (gender, noun) where gender == "der":
        print("\(noun) => Masculine noun")
    case let (gender, noun) where gender == "die":
        print("\(noun) => Feminine noun")
    case let (gender, noun) where gender == "das":
        print("\(noun) => Neuter noun")
    case let (gender, noun):
        print("\(gender) \(noun) => Unknown gender input")
}

print("=============== Continue ===============")
for num in 1...20{
    if num % 5 == 0 {
        continue
    }
    print(num, terminator: ",")
}
print("")

print("=============== Break ===============")
for num in 1...20{
    if num % 5 == 0 {
       break 
    }
    print(num, terminator: ",")
}
print("")

print("=============== Break in Switch ===============")
for num in 1...10 {
    switch num {
        case num where num != 2 && num % 2 == 0:
            break
        case num where num != 3 && num % 3 == 0:
            break
        case num where num != 5 && num % 5 == 0:
            break
        default:
            print("\(num) is a prime number")
    }
}

print("=============== fallthrough in switch ===============")
let randomNumber = 49
switch randomNumber {
    case 1...50:
        print("1-50")
        fallthrough
    case 51...100:
        print("51-100")
        fallthrough
    default:
        print("Don't ever use 'switch' again!")
}

print("=============== Labeled Statements ===============")
import Foundation
var inputCharactor = "c"
var loopCount = 1
requestExitLoop: while inputCharactor != "y" {
    if loopCount > 10 {
        print("Exiting...")
        break requestExitLoop
    } else if loopCount % 3 == 0 {
        print("Accelerating...")
        loopCount += 1
        continue requestExitLoop
    } 
    print("Loop #\(loopCount):", terminator:"")
    for _ in 0...20 {
        print("/", terminator:"")
        Thread.sleep(forTimeInterval: 0.05)
    }
    print("\nForcing Exit...")
    loopCount += 1
}

print("=============== Early Exit ===============")
loopCount = 1
while inputCharactor != "y" {
    guard loopCount < 11 else {
        print("Exiting...")
        break 
    } 
    if loopCount % 3 == 0 {
        print("Accelerating...")
        loopCount += 1
        continue 
    } 
    print("Loop #\(loopCount):", terminator:"")
    for _ in 0...20 {
        print("/", terminator:"")
        Thread.sleep(forTimeInterval: 0.05)
    }
    print("\nForcing Exit...")
    loopCount += 1
}

