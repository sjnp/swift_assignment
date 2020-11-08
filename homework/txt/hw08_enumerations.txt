// HW8: Enumerations 
//=================================================================================================================
print("=============== Enumeration Syntax ===============")
enum Protein {
    case pork
    case fish
    case meat
    case chicken
}

enum Vegetables {
    case onion, lattuce, carrot, cabbage 
}

var proteinPick = Protein.pork
print(type(of: proteinPick), ":", proteinPick) // Protein : pork
proteinPick = .fish
print(type(of: proteinPick), ":", proteinPick) // Protein : fish
// error proteinPick = Vegetables.Onion

print("=============== Enumeration with Switch ===============")
func foodSuggestion(with protein: Protein) {
    switch protein {
    case .pork:
        print("Fried pork with \(Vegetables.cabbage)") // Fried pork with cabbage
    case .fish:
        print("Fried fish with \(Vegetables.onion)") // Fried fish with onion
    case .meat:
        print("Grilled meat with \(Vegetables.onion)") // Grilled meat with onion
    case .chicken:
        print("Salad with boiled chicken and \(Vegetables.lattuce)") // Salad with boiled chicken and lattuce
    }
}

foodSuggestion(with: Protein.chicken) // Salad with boiled chicken and lattuce

func saladSuggestion(with vegie: Vegetables) {
    switch vegie {
    case .onion, .lattuce, .carrot:
        print("\(vegie) can be in the salad")
    default:
        print("\(vegie) cannot be in the salad")
    }
}

saladSuggestion(with: Vegetables.onion) // onion can be in the salad
saladSuggestion(with: Vegetables.cabbage) // cabbage cannot be in the salad

print("=============== Iterating over Enumeration Cases ===============")
enum Taste: CaseIterable {
    case sweet, salty, sour
}
let tasteList = Taste.allCases
print("Taste.allCases is", type(of: tasteList))
print("Taste has", tasteList.count, "cases :")
for taste in tasteList {
    print(taste, terminator: " ")
}
print("")

print("=============== Associated Values ===============")
enum FoodIngredient {
    case withMeat(Protein, Vegetables)
    case withoutMeat(Vegetables, Vegetables)
}

var myFood = FoodIngredient.withMeat(.pork, .carrot)

func showFoodIngredient(of food: FoodIngredient) {
    switch food {
        case .withMeat(let protein, let fiber):
            print("\(protein) with \(fiber)")
        case let .withoutMeat(firstFiber, secondFiber):
            print("\(firstFiber) and \(secondFiber)")
    }
}

showFoodIngredient(of: myFood) // pork with carrot
myFood = .withoutMeat(.carrot, .lattuce)
showFoodIngredient(of: myFood) // carrot and lattuce

print("=============== Raw Values ===============")
enum MathConstant: Double {
    case pi = 3.14159
    case e = 2.71828
    case sqrOf2 = 1.41421
}
print("Pi =", MathConstant.pi.rawValue)
print("Euler's number =", MathConstant.e.rawValue)
print("Square root of 2 =", MathConstant.sqrOf2.rawValue)

print("=============== Implicitly Assigned Raw Values ===============")
enum IntEnum: Int {
    case first = 2
    case second
    case third 
}
print("3rd value is", IntEnum.third.rawValue) // 4

enum Vowel: String, CaseIterable {
    case a
    case e
    case i
    case o 
    case u 
}
print("Vowels :", terminator:" ")
for i in Vowel.allCases {
    print(i, terminator: " ")
}
print("")
/*
This does not work because implicit raw values must be int or string!
enum Vowel: Character, CaseIterable {
    case a
    case e
    case i
    case o 
    case u 
}
*/
print("=============== Initializing From Raw Values ===============")
enum MeatWithPrice: Int, CaseIterable {
    case chicken = 35
    case pork = 40
    case meat = 50
    case fish = 60
}
var optionalMeat = MeatWithPrice(rawValue: 20)
print(type(of: optionalMeat)) // Optional<MeatWithPrice>

func purchase(with coin: Int) {
    // use optional binding
    if let purchasedMeat = MeatWithPrice(rawValue: coin) {
        print(purchasedMeat, coin, "Baht")
    } else {
        print("Please pay with the exact value that is", terminator: " ")
        for i in MeatWithPrice.allCases {
            print(i.rawValue, terminator: " ")
        }
        print("")
    }
}

purchase(with: 40)  // pork 40 Baht
purchase(with: 100) // Please pay with the exact value that is 35 40 50 60

print("=============== Recursive Enumerations ===============")
enum BooleanExpression {
    case booleanVar(Bool)
    indirect case and(BooleanExpression, BooleanExpression)
    indirect case or(BooleanExpression, BooleanExpression)
    indirect case not(BooleanExpression)
}
func evaluate(_ expression: BooleanExpression) -> Bool {
    switch expression {
    case let .booleanVar(booleanValue):
        return booleanValue
    case let .and(p, q):
        return evaluate(p) && evaluate(q)
    case let .or(p, q):
        return evaluate(p) || evaluate(q)
    case let .not(p):
        return !evaluate(p)
    }
}

// ~p v q == ~(true) v false
let p = BooleanExpression.booleanVar(true)
let q = BooleanExpression.booleanVar(false)
let sentence = BooleanExpression.or(BooleanExpression.not(p), q)
if evaluate(sentence) == false {
    print("true -> false == false")
}