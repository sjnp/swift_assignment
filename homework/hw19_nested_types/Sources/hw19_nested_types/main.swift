// HW19: Nested types 
//=================================================================================================================
print("=============== Nested types in action ===============")
class Ingredient {
    enum Protein: Int {
        case chicken = 80, meat = 140, pork = 120, fish = 180
    }
    struct Fiber {
        enum Vegetable: Int {
            case lattuce = 5, onion = 8, tomato = 10
        }
        enum Herb: Int {
            case pepper = 3, rosemary = 5, parsley = 7
        }
        let vegetable: Vegetable, herb: Herb
    }
    let protein: Protein
    let fiber: Fiber
    var cost: Int {
        return protein.rawValue + 
            fiber.vegetable.rawValue +
            fiber.herb.rawValue
    }
    var description: String {
        return "\(protein) with \(fiber.vegetable) and \(fiber.herb) : \(cost) Baht."
    }
    init(protein: Protein, fiber: Fiber) {
        self.protein = protein
        self.fiber = fiber
    }
}

// Protein enum & Fiber struct is in the scope of Ingredient Class
// But only the struct that need to use 'Ingredient.Fiber()'
let a = Ingredient(protein: .chicken, fiber: Ingredient.Fiber(vegetable: .lattuce, herb: .pepper))

print(a.description)   // chicken with lattuce and pepper : 88 Baht.

print("=============== Referring to nested types ===============")
let costOfPepper = a.fiber.herb.rawValue
let costOfLattuce = Ingredient.Fiber.Vegetable.lattuce.rawValue
let costOfChicken = Ingredient.Protein.chicken.rawValue
print("cost: \(costOfChicken + costOfLattuce + costOfPepper)")

print("=============== Need more testing...??? ===============")