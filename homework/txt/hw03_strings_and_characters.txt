// HW3: Strings & Character
//=================================================================================================================
// String Literals with implicitly unwrapped optional
print("================ String Literals ================")
let greetingMessage: String! = "guten"
print(greetingMessage!)

print("================ Multitiline =================")
// Multiline string literals
let multilineMessage1: String! = """
    This is in the first line - IUO.
    This is in the second line - IUO.
"""
let multilineMessage2: String = """
    This is in the first line - String.
    This is in the second line - String.
    """
print("""
    This is in the first line - print.
    This is in the second line - print.
    """)
print(multilineMessage1!)
print(multilineMessage2)
print("=> Only Optional of String that have tabs on multiline\n")
let multilineMessageWithNoLineBreak: String! = """
In the code this is a multiline.\
 But when printing, there will look like a single line.\
 Because we use \\ to the end of lines in the code
"""
print(multilineMessageWithNoLineBreak!)
let noLineBreakAtBottom: String! = """
Do not put \\ at the bottom of the multiple line.\
 Because escaped newline at the last line is not allowed.
""" 
print(noLineBreakAtBottom!)

let multilineMessageWithLineFeed: String! = """

So you want an empty line before
and after this message,
just add empty lines then!

"""
print(multilineMessageWithLineFeed!)

print("================ Special Characters ================")
print("This is \0 Yeah it's null \\0, got it?")
print("""
    if i = 0:
    \tprint("This is tabbed.")
    """)
print("Use \\r to replace a word")
let iAmAMan = "Ich bin ein Mann."
print(iAmAMan)          //print 'Ich bin ein Mann.'
print("Replace \"I am\" with \"You are\"")
let uAreAMan = "\(iAmAMan)\rDu bist"
print(uAreAMan)         //print 'Du bist ein Mann.'

let manEmoji = "\u{1F468}"
print("\(iAmAMan)\(manEmoji)")
//----------------------------------------------------------------------------------------------------------------
print("=============== Extended String Delimiters ===============")
print(#"Man Emoji Unicode: \u{1F468}"#)
print(#"\u{1f468}: \#u{1F468}"#)

print("=============== Empty String ===============")
let optionalEmptyString: String! = ""
if let emptyString = optionalEmptyString {
    print("\(emptyString)Optional of empty string is not nil!")
}

print("=============== String Mutability ===============")
if var goodMorning = greetingMessage {
    goodMorning += " Morgen"
    print(goodMorning)
}

print("=============== Character ===============")
print("\(manEmoji) is", type(of: manEmoji), ",because the default declaration will always be String.")
let manCharacterEmoji: Character = "\u{1F468}"
print(#"\(manCharacterEmoji) \#(manCharacterEmoji) is"#, type(of: manCharacterEmoji))
print(#"\(manEmoji) \#(manEmoji) is"#, type(of: manEmoji))
let stringToCharacter = Character(manEmoji)
print(#"""
This string "\#(manEmoji)" can be converted into 
\#(type(of: stringToCharacter)) "\#(stringToCharacter)" because it's 
only have one charactor.
"""#)
print("Converting string into character does not generate optional!")

print("=============== for Character in String ===============")
let bearsEmoji: String = "\u{1F43B}\u{1F428}\u{1F43C}"
print("\(bearsEmoji) is", type(of: bearsEmoji))
for bear in bearsEmoji {
    print("\(bear) is", type(of: bear))
}

print("=============== Array of Characters => String ==============")
let bearsEmojiArr: [Character] = ["\u{1F43B}", "\u{1F428}", "\u{1F43C}"]
print("\(bearsEmojiArr) is", type(of: bearsEmojiArr))
let bearsEmojiArrToString = String(bearsEmojiArr)
print("\(bearsEmojiArrToString) is", type(of: bearsEmojiArrToString))

print("=============== String => Character? ==============")
print("let bearsEmojiArrToStringToChar = Character(bearsEmojiArrToString)")
print("""
The above line will crash the program because a String contain more than one
extended grapheme cluster.
Why not creating String Optional when converting a String to Character?\u{1F914}
""")

print("=============== Concatenating ==============")
let optionalString1: String! = "Optional1"
let optionalString2: String! = "Optional2"
let optionalPanda: Character! = "\u{1F43C}"
var concatOptional = optionalString1 + optionalString2
print("This is optionalString concat optionalString:", concatOptional)
concatOptional = optionalString1
concatOptional.append(optionalPanda)
print("This is optionalString concat optionalChar:", concatOptional)

print("=============== Extended Grapheme Cluster ==============")
let aUmlauteOneScalar: Character = "\u{00E4}"
let aUmlauteTwoScalars: Character = "\u{0061}\u{0308}"
print("One Scalar:", aUmlauteOneScalar)
print("Two Scalar:", aUmlauteTwoScalars)
if aUmlauteOneScalar == aUmlauteTwoScalars {
    print("\(aUmlauteOneScalar) is equal to \(aUmlauteTwoScalars)")
}
let menWithOneScalar = "M\(aUmlauteOneScalar)nner"
let menWithTwoScalars = "M\(aUmlauteTwoScalars)nner"
print("Men = \(menWithOneScalar) => One Scalar")
print("Men = \(menWithTwoScalars) => Two Scalars")

print("=============== Counting Characters ==============")
print("\(menWithOneScalar) has \(menWithOneScalar.count) alphabets => One Scalar")
print("\(menWithTwoScalars) has \(menWithTwoScalars.count) alphabets => Two Scalars")
print("Warning!!!: Do not use 'count' with type 'Character'.\n")
print("Optional String can be counted => \"\(optionalString1!)\": \(optionalString1.count) Chars")
print("Warning!!!: Do not use 'count' with optional with 'nil'.\n")

print("=============== String Indices ==============")
print("Bears in emoji: \(bearsEmoji)")
print("First bear: \(bearsEmoji[bearsEmoji.startIndex])")
print("Second bear: \(bearsEmoji[bearsEmoji.index(after: bearsEmoji.startIndex)])")
print("Third bear: \(bearsEmoji[bearsEmoji.index(before: bearsEmoji.endIndex)])")
let bearIndex = bearsEmoji.startIndex
print("\(bearsEmoji[bearIndex]) is \(bearIndex)")
let koalaIndex = bearsEmoji.index(after: bearIndex)
print("\(bearsEmoji[koalaIndex]) is \(koalaIndex)")
let pandaIndex = bearsEmoji.index(bearIndex, offsetBy: 2)
print("\(bearsEmoji[pandaIndex]) is \(pandaIndex)")

print("=============== Inserting and Removing ==============")
let morning = "Morgen"
var greetingInTime = greetingMessage!
greetingInTime.insert(contentsOf: " \(morning)", at: greetingInTime.endIndex)
print("Good Morning <=> \(greetingInTime)")
greetingInTime.insert(manCharacterEmoji, at: greetingInTime.endIndex)
print("Add \(manCharacterEmoji): Good Morning\(manCharacterEmoji) <=> \(greetingInTime)")
greetingInTime.remove(at: greetingInTime.index(before: greetingInTime.endIndex))
print("Remove \(manCharacterEmoji): Good Morning <=> \(greetingInTime)")
greetingInTime.removeSubrange(greetingInTime.index(greetingInTime.endIndex, offsetBy: -7)..<greetingInTime.endIndex)
print("Good <=> \(greetingInTime)")

print("=============== Substrings ==============")
greetingInTime = greetingInTime + " " + morning
print(type(of: greetingInTime), ":", greetingInTime)
if let index = greetingInTime.firstIndex(of: "M") {
    let morningSubstring = greetingInTime[index..<greetingInTime.endIndex]
    print(type(of: morningSubstring), ":", morningSubstring)
    if morningSubstring == morning {
        print(#"\#(type(of: morningSubstring)) "\#(morningSubstring)" is equal to \#(type(of: morning)) "\#(morning)"."#)
    }
}

print("=============== Prefix & Suffix ==============")
let greetingInTimeArr = [
    "guten Tag",
    "guten Morgen",
    "guten Abend",
    "guten Nacht"
]
var greetingCount = 0
for greeting in greetingInTimeArr {
    if greeting.hasPrefix("guten") {
        greetingCount += 1
        if greeting.hasSuffix("Tag") {
            print(greeting, ": Anytime")
        } else if greeting.hasSuffix("Morgen") {
            print(greeting, ": 5 a.m. - 11 a.m.")
        } else if greeting.hasSuffix("Abend") {
            print(greeting, ": 6 p.m. - 10 p.m.")
        } else if greeting.hasSuffix("Nacht") {
            greetingCount -= 1
            print(greeting, ": Good night")
        }
    }
}
print("There are \(greetingCount) greeting messages")

print("=============== Unicode Viewing ==============")
print("UTF-8")
print(aUmlauteOneScalar, terminator: ": ")
for codeUnit in aUmlauteOneScalar.utf8 {
    print(codeUnit, terminator: " ")
}
print("")
print(aUmlauteTwoScalars, terminator: ": ")
for codeUnit in aUmlauteTwoScalars.utf8 {
    print(codeUnit, terminator: " ")
}
print("")
print("UTF-16")
print(aUmlauteOneScalar, terminator: ": ")
for codeUnit in aUmlauteOneScalar.utf16 {
    print(codeUnit, terminator: " ")
}
print("")
print(aUmlauteTwoScalars, terminator: ": ")
for codeUnit in aUmlauteTwoScalars.utf16 {
    print(codeUnit, terminator: " ")
}
print("")
print("Unicode Scalar")
print(aUmlauteOneScalar, terminator: ": ")
for codeUnit in aUmlauteOneScalar.unicodeScalars {
    print(codeUnit.value, terminator: " ")
}
print("")
print(aUmlauteTwoScalars, terminator: ": ")
for codeUnit in aUmlauteTwoScalars.unicodeScalars {
    print(codeUnit.value, terminator: " ")
}
print("")
print("In UTF-16 & Unicode Scalar, \(aUmlauteOneScalar) & \(aUmlauteTwoScalars) have the same values.")