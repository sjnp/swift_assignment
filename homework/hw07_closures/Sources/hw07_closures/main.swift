// HW7: Closures 
//=================================================================================================================
print("=============== The Sorted Method ===============")
let fruits = ["Cherry", "Orange", "Kiwi", "Banana", "Coconut", "Melon"]
print("Before using forward sorting:", fruits)
func forward(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}
var forwardSortedFruits = fruits.sorted(by: forward)
print("Forward sorting:", forwardSortedFruits)
print("")

print("=============== Closure Expression Syntax ===============")
forwardSortedFruits = fruits.sorted(by: {(s1: String, s2: String) -> Bool in return s1 < s2})
print("Forward sorting closure:", forwardSortedFruits)
print("")

print("=============== Inferring Type from Context ===============")
forwardSortedFruits = fruits.sorted(by: {s1, s2 in return s1 < s2})
print("Forward sorting closure with inferred type:", forwardSortedFruits)
print("")

print("=============== Implicit Returns from Single-Expression Closures ===============")
forwardSortedFruits = fruits.sorted(by: {s1, s2 in s1 < s2})
print("Forward sorting closure with implicit return:", forwardSortedFruits)
print("")

print("=============== Shorthand Argument Names ===============")
forwardSortedFruits = fruits.sorted(by: {$0 < $1})
print("Forward sorting closure with shorthand argument names $0, $1:", forwardSortedFruits)
print("")

print("=============== Operator Methods ===============")
forwardSortedFruits = fruits.sorted(by: >)
print("Forward sorting closure with operator methods:", forwardSortedFruits)
print("")

print("=============== Trailing Closures ===============")
forwardSortedFruits = fruits.sorted() {$0 > $1}
// () can be removed because the closure expression is the only argument of 'sorted()'
forwardSortedFruits = fruits.sorted {$0 < $1}
print("Forward sorting closure with trailing closure:", forwardSortedFruits)
print("")
    
let fruitsWithPrice = [
    "Apple": 25,
    "Banana": 49,
    "Cherry": 129,
    "Coconut": 39,
    "Kiwi": 20,
    "Melon": 60,
    "Orange": 17,
]
let customerFruitOrder = [
    "Orange": 4,
    "Banana": 1,
    "Kiwi": 5,
    "Coconut": 2
]
let customerOrderCosts = customerFruitOrder.keys.map { (fruit) -> Int in
    return customerFruitOrder[fruit]!*fruitsWithPrice[fruit]!
}
var totalCost = 0
for cost in customerOrderCosts {
    totalCost += cost
}
print("Fruits' Price :", fruitsWithPrice)
print("Customer's Order :", customerFruitOrder)
print("Total Cost =", totalCost)

print("=============== Capturing Values ===============")
func orderFruit(is fruit: String) -> () -> (String, Int, Int) {
    var fruit = fruit
    var totalFruitCost = 0
    var totalFruit = 0
    func order() -> (String, Int, Int) {
        if let fruitCost = fruitsWithPrice[fruit] {
            totalFruitCost += fruitCost
            totalFruit += 1
        } else {
            totalFruitCost += 0
            totalFruit += 1
            fruit = "NULL"
        }
        return (fruit, totalFruit, totalFruitCost)
    }
    return order
}

let appleOrder = orderFruit(is: "Apple")
var order = appleOrder()    // ("Apple", 1, 25)
print("You ordered \(order.0) \(order.1) times. Total cost is \(order.2) ฿.")
order = appleOrder()        // ("Apple", 2, 50)
print("You ordered \(order.0) \(order.1) times. Total cost is \(order.2) ฿.")

let nullOrder = orderFruit(is: "Pineapple")
order = nullOrder()         // ("NULL", 1, 0)
print("You ordered \(order.0) \(order.1) times. Total cost is \(order.2) ฿.")

order = appleOrder()        // ("Apple", 3, 75)
print("You ordered \(order.0) \(order.1) times. Total cost is \(order.2) ฿.")

print("=============== Escaping Closures ===============")
var orderQueue: [() -> (String, Int, Int)] = []
func awaitOrder(_ order: @escaping () -> (String, Int, Int)) {
    orderQueue.append(order)
}
awaitOrder(orderFruit(is: "Apple"))
// *** This is a different reference from the old 'order' ***
order = orderQueue[0]()     // ("Apple", 1, 25)
print("You ordered \(order.0) \(order.1) times. Total cost is \(order.2) ฿.")

print("=============== Autoclosures ===============")
awaitOrder(orderFruit(is: "Orange"))    
awaitOrder(orderFruit(is: "Coconut"))
awaitOrder(orderFruit(is: "Kiwi"))      // orderQueue = [Apple, Orange, Coconut, Kiwi]
print("#Queues:", orderQueue.count)     // 4

let completionOrder = { orderQueue.remove(at: 0)}
print("#Queues:", orderQueue.count)     // 4

print("Order completed:", completionOrder()())
print("#Queues:", orderQueue.count)     // orderQueue = [Orange, Coconut, Kiwi]

func completeOrder(with completionOrder: () -> () -> (String, Int, Int)) {
    print("Order completed:", completionOrder()())
}
completeOrder(with: { orderQueue.remove(at: 0)})
print("#Queues:", orderQueue.count)     // orderQueue = [Coconut, Kiwi]

// With @autoclosure
func completeOrder(with completionOrder: @autoclosure () -> () -> (String, Int, Int)) {
    print("Order completed:", completionOrder()())
}
completeOrder(with: orderQueue.remove(at: 0))
print("#Queues:", orderQueue.count)     // orderQueue = [Kiwi]

// With @autoclosure and @escaping
awaitOrder(orderFruit(is: "Cherry"))
awaitOrder(orderFruit(is: "Melon"))
print("#Queues:", orderQueue.count)     // orderQueue = [Kiwi, Cherry, Melon]
var readyOrderQueue: [() -> () -> (String, Int, Int)] = []

func collectReadyOrders(from completionOrder: @autoclosure @escaping ()
    -> () -> (String, Int, Int)) {
        readyOrderQueue.append(completionOrder)
}
collectReadyOrders(from: orderQueue.remove(at: 0))
collectReadyOrders(from: orderQueue.remove(at: 0))
print("#Ready-To-Complete Orders:", readyOrderQueue.count) // 2
print("#Queues:", orderQueue.count)     // orderQueue = [Kiwi, Cherry, Melon]
for order in readyOrderQueue {
    print("Order completed:", order()())
}
print("#Queues:", orderQueue.count)     // orderQueue = [Melon]
