// HW4: Collection Types 
//=================================================================================================================
print("=============== Empty Array ===============")
var smilingEmojis = [Character]()
if smilingEmojis.count == 0 {
    print(smilingEmojis, "is empty")
}
smilingEmojis.append("\u{1F600}")
print(smilingEmojis, "has \(smilingEmojis.count) emoji")
smilingEmojis = []
print(smilingEmojis, "has \(smilingEmojis.count) emoji")

print("=============== Repeating in Array ===============")
smilingEmojis = Array(repeating: "\u{1F600}", count: 4)
print(smilingEmojis, "has \(smilingEmojis.count) emojis")

print("=============== Adding Arrays ===============")
smilingEmojis = smilingEmojis + smilingEmojis + smilingEmojis
print(smilingEmojis, "has \(smilingEmojis.count) emojis")

print("=============== Array with Array Literals ===============")
smilingEmojis = ["\u{1F600}", "\u{1F601}", "\u{1F602}"]
var animalEmojis: [Character] = ["\u{1F415}", "\u{1F408}"]
var emojis = [smilingEmojis, animalEmojis]
print(type(of: smilingEmojis), smilingEmojis, "has \(smilingEmojis.count) emojis")
print(type(of: animalEmojis), animalEmojis, "has \(animalEmojis.count) emojis")
print(type(of: emojis) ,emojis, "has \(emojis.count) arrays")

print("=============== Accessing and Modifying an Array ===============")
if emojis.isEmpty {
    print(type(of: emojis), emojis, "is empty")
}   else {
    print(type(of: emojis) ,emojis, "is not empty")
}

print("Before Append:", emojis)
emojis[0].append("\u{1F604}")
emojis[1] += ["\u{1F40E}", "\u{1F98C}"]
print("After Append:", emojis)

emojis[0][emojis[0].count-1] = "\u{1F607}"
print("After Edit:", emojis)

emojis[1][4...] = ["\u{1F416}", "\u{1F404}"]
print("After Replace:", emojis)

emojis[1].insert("\u{1F999}", at: emojis[1].count-1)
print("After Insert:", emojis)

var removedEmoji: [Character] = [emojis[0].remove(at: emojis[0].count-1)]
print("After Remove(At:):", emojis)

removedEmoji += [emojis[1].removeLast()]
print("After RemoveLast():", emojis)
print(type(of: removedEmoji), removedEmoji, "is removed")

print("=============== Iterating Over an Array ===============")
for emoji in removedEmoji {
    print(type(of: emoji), emoji, "is removed")
}

print("=============== Creating and Initializing a Set ===============")
var umlauteWithOneScalar = Set<Character>()
umlauteWithOneScalar.insert("\u{00E4}")
umlauteWithOneScalar.insert("\u{00F6}")
umlauteWithOneScalar.insert("\u{00FC}")
print("Set of one-scalar umlautes:", umlauteWithOneScalar)
var umlauteWithTwoScalar: Set<Character> = ["\u{0061}\u{0308}", "\u{006F}\u{0308}", "\u{0075}\u{0308}"]
print("Set of two-scalar umlautes:", umlauteWithTwoScalar)

print("=============== Accessing and Modifying a Set ===============")
umlauteWithOneScalar.insert("\u{0061}\u{0308}")
print("After insert \u{0061}\u{0308} :", umlauteWithOneScalar)
umlauteWithOneScalar.insert("\u{006F}\u{0308}")
print("After insert \u{006F}\u{0308} :", umlauteWithOneScalar)
umlauteWithOneScalar.insert("\u{0075}\u{0308}")
print("After insert \u{0075}\u{0308} :", umlauteWithOneScalar)
print("It's still look the same because these two sets have the same hash value")
print("1st set's hash:", umlauteWithOneScalar.hashValue)
print("2nd set's hash:", umlauteWithTwoScalar.hashValue)

if let removeUmlaute = umlauteWithOneScalar.remove("\u{0061}\u{0308}") {
    print("After remove \(removeUmlaute):" ,umlauteWithOneScalar)
}
if umlauteWithOneScalar.contains("\u{006F}\u{0308}") {
    print("\u{006F}\u{0308} is in \(umlauteWithOneScalar)")
}
print("Sorted set from sort() is:", type(of: umlauteWithTwoScalar.sorted()), umlauteWithTwoScalar.sorted())

print("=============== Set Operations ===============")
var someChar: Set<Character> = ["a", "u", "o"]
someChar = someChar.union(umlauteWithOneScalar)
print("someChar set:", someChar)
print("\(someChar) intersects \(umlauteWithTwoScalar) =", someChar.intersection(umlauteWithTwoScalar))
print("\(someChar) unions \(umlauteWithTwoScalar) =", someChar.union(umlauteWithTwoScalar))
print("\(someChar) subtracts \(umlauteWithTwoScalar) =", someChar.subtracting(umlauteWithTwoScalar))
print("Symmetric difference of \(someChar) and \(umlauteWithTwoScalar) =", someChar.symmetricDifference(umlauteWithTwoScalar))

if umlauteWithOneScalar.isSubset(of: someChar) {
    print("\(umlauteWithOneScalar) is a subset of \(someChar)")
}
if someChar.isSuperset(of: umlauteWithOneScalar) {
    print("\(someChar) is a superset of \(umlauteWithOneScalar)")
}
if !someChar.isDisjoint(with: umlauteWithTwoScalar) {
    print("\(someChar) and \(umlauteWithTwoScalar) have some values in common")
}

print("=============== Creating an Empty Dictionary ===============")
var genders = [String: Character]() 
genders["Male"] = "\u{1F468}"
genders["Female"] = "\u{1F469}"
print(type(of: genders), genders)

print("=============== Creating a Dictionary with a Dictionary Literal ===============")
var animals: [String: Character] = [
    "Zebra": "\u{1F993}", 
    "Giraffe": "\u{1F992}", 
    "Kangaroo": "\u{1F998}",
    "Penguin": "\u{1F427}"
    ]
print(type(of:animals), animals)

print("=============== Accessing and Modifying a Dictionary ===============")
var aouAlphabet = [String: Set<Character>]() 
print("This aouAlphabet dictionary has \(aouAlphabet.count) things")
if aouAlphabet.isEmpty {
    print("This aouAlphabet dictionary is empty")
}
aouAlphabet["No Umlautes"] = someChar
aouAlphabet["1-Scalar Umlautes"] = umlauteWithOneScalar
aouAlphabet["2-Scalar Umlautes"] = umlauteWithTwoScalar
print(type(of:aouAlphabet), aouAlphabet)
if let oldNoUmlautes = aouAlphabet.updateValue(Set(["a", "o", "u"]), forKey: "No Umlautes") {
    print("The old 'No Umlautes' set: \(oldNoUmlautes)")
    if let newNoUmlautes = aouAlphabet["No Umlautes"] {
        print("The new 'No Umlautes' set:", newNoUmlautes)
    }
}
if let removedSet = aouAlphabet.removeValue(forKey: "1-Scalar Umlautes") {
    print("This set \(removedSet) got removed from the Dictionary")
}

print("=============== Iterating Over a Dictionary ===============")
for key in aouAlphabet.keys {
    print("Key: \(key)")
}
for value in aouAlphabet.values {
    print("Set: \(value)")
}
for (key, value) in aouAlphabet {
    print("\(key): \(value)")
}
