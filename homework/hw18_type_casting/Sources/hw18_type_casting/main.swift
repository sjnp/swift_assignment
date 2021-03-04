// HW18: Deinitialization 
//=================================================================================================================
print("=============== Defining a class hierarchay for Type Casting ===============")
class Ingredient {
    var name: String
    var weight: UInt
    init(name: String, weight: UInt) {
        self.name = name
        self.weight = weight
    }
}
class Meat: Ingredient {
    var isFrozen: Bool 
    init(name: String, weight: UInt, isFrozen: Bool) {
        self.isFrozen = isFrozen
        super.init(name: name, weight: weight)
    }
}
class Fish: Meat {
    var isSliced: Bool
    init(name: String, weight: UInt, isFrozen: Bool, isSliced: Bool) {
        self.isSliced = isSliced
        super.init(name: name, weight: weight, isFrozen: isFrozen)
    }
}
class Herb: Ingredient {
    var isDried: Bool
    init(name: String, weight: UInt, isDried: Bool) {
        self.isDried = isDried
        super.init(name: name, weight: weight)
    }
}
let stock = [
    Herb(name: "Rosemary", weight: 50, isDried: true),
    Meat(name: "Beef", weight: 200, isFrozen: true),
    Fish(name: "Tuna", weight: 250, isFrozen: false, isSliced: true)
]
print(type(of: stock))  // Array<Ingredient>
for ingredient in stock {
    print("This \(ingredient.name) is \(type(of: ingredient))")
}
// This Rosemary is Herb
// This Beef is Meat
// This Tuna is Fish

print("=============== Checking type ===============")
// use 'is' as a type check operator
for ingredient in stock {
    if ingredient is Herb {
        print("Herb: \(ingredient.name)")
    } else if ingredient is Meat {
        print("Meat: \(ingredient.name)")
    } else if ingredient is Fish {
        print("Fish: \(ingredient.name)")
    } else {
        print("Unknown: \(ingredient.name)")
    }
}
// Herb: Rosemary
// Meat: Beef
// Meat: Tuna

print("=============== Downcasting ===============")
for ingredient in stock {
    if let meat = ingredient as? Meat {
        print("Frozen \(meat.name) : \(meat.isFrozen)")
    } else if let herb = ingredient as? Herb {
        print("Dried \(herb.name) : \(herb.isDried)")
    } else {
        print("Unknown: \(ingredient.name)")
    }
}
// dried rosemary : true
// frozen beef : true
// frozen tuna : false

enum FishError: Error {
    case notFish
}

func checkFish(from ingredient: Ingredient) throws {
    guard let _ = ingredient as? Fish else {
        throw FishError.notFish
    }
}

func checkSlicedFish(from stock: Array<Ingredient>, withThrower: (Ingredient) throws -> ()) {
    for ingredient in stock {
        do {
            try withThrower(ingredient)
            // Forced downcasting with 'as!'
            let fish = ingredient as! Fish
            if fish.isSliced {
                print("\(fish.name) is sliced")
            } else {
                print("\(fish.name) is not sliced")
            }
        } catch FishError.notFish {
            print("\(ingredient.name) is not a fish")
        } catch {
            print("Unexpected error with \(ingredient.name) : \(type(of: ingredient))")
        }
    }
}
checkSlicedFish(from: stock, withThrower: checkFish)
// Rosemary is not a fish
// Beef is not a fish
// Tuna is sliced

print("=============== Type Casting for Any and AnyObject ===============")
var anyArray = [Any]()
// anyArray.append(nil) --> this will give an error: 'nil' is not compatible with type 'Any'
let optionalUInt: UInt? = 0
anyArray.append(optionalUInt)        // this will give a warning
anyArray.append(optionalUInt as Any) // this will give no warning
anyArray.append(Ingredient(name: "Thyme", weight: 20))
print(type(of: anyArray))            // Array<Any>
for thing in anyArray {
    print(type(of: thing))
}
// Optional<UInt>
// Optional<UInt>
// Ingredient

var anyObjectArray = [AnyObject]()
// anyObjectArray.append(optionalUInt)        --> this will give an error: expected to be an instance
// anyObjectArray.append(optionalUInt as Any) --> this will give the same error
// anyObjectArray.append(stock)               --> this will give the same error
anyObjectArray.append(optionalUInt as AnyObject) // this will pass
anyObjectArray.append(stock as AnyObject)        // this will pass
anyObjectArray.append(stock[0])
print(type(of: anyObjectArray))     // Array<AnyObject>
for thing in anyObjectArray {
    print(type(of: thing))
}
// __SwiftValue
// __SwiftValue
// Herb

class Container {
    var material: String
    init(material: String) { self.material = material }
}
class Plate: Container {
    var isMicrowavable: Bool
    init(material: String, isMicrowavable: Bool) {
        self.isMicrowavable = isMicrowavable
        super.init(material: material)
    }
}
class Bottle: Container {
    var isRecyclable: Bool
    init(material: String, isRecyclable: Bool) {
        self.isRecyclable = isRecyclable
        super.init(material: material)
    }
}

var thingsInKitchen = [AnyObject]()
thingsInKitchen.append(Meat(name: "Beef", weight: 250, isFrozen: false))
thingsInKitchen.append(Fish(name: "Salmon", weight: 300, isFrozen: true, isSliced: true))
thingsInKitchen.append(Herb(name: "Parsley", weight: 15, isDried: true))
thingsInKitchen.append(Plate(material: "Aluminium", isMicrowavable: false))
thingsInKitchen.append(Bottle(material: "Glass", isRecyclable: true))
thingsInKitchen.append(optionalUInt as AnyObject)

for thing in thingsInKitchen {
    switch thing {
        case let meat as Meat:
            if meat.isFrozen {
                print("\(meat.weight) g. frozen \(meat.name)")
            } else {
                print("\(meat.weight) g. fresh \(meat.name)")
            }
        case let fish as Fish:
            if fish.isSliced && fish.isFrozen {
                print("\(fish.weight) g. frozen sliced \(fish.name)")
            } else if fish.isSliced {
                print("\(fish.weight) g. fresh sliced \(fish.name)")
            } else if fish.isFrozen {
                print("\(fish.weight) g. frozen \(fish.name)")
            } else {
                print("\(fish.weight) g. fresh \(fish.name)")
            }
        case let herb as Herb:
            if herb.isDried {
                print("\(herb.weight) g. dried \(herb.name)")
            } else {
                print("\(herb.weight) g. fresh \(herb.name)")
            }
        case let plate as Plate:
            if plate.isMicrowavable {
                print("Microwavable \(plate.material) plate")
            } else {
                print("Non-microwavable \(plate.material) plate")
            }
        case let bottle as Bottle:
            if bottle.isRecyclable {
                print("Recyclable \(bottle.material) bottle")
            } else {
                print("Non-recyclable \(bottle.material) bottle")
            }
        default:
            print("Unexpected object: \(thing)")
    }
}
// 250 g. fresh Beef
// 300 g. frozen Salmon
// 15 g. dried Parsley
// Non-microwavable Aluminium plate
// Recyclable Glass bottle
// Unexpected object: 0