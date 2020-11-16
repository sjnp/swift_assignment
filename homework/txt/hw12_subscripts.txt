// HW12: Subscripts 
//=================================================================================================================
print("=============== Subscript Syntax & Usage ===============")
struct Fruit {
    var fruitPrice: [String: Int]
    subscript(key: String) -> Int {
        /// Return -99 for nil
        fruitPrice[key] ?? -99
    }
}

let myFruit = Fruit(fruitPrice: [
    "banana": 20,
    "apple": 10,
    "orange": 30
])

print("apple price is", myFruit["apple"])       /// apple price is 10
print("coconut price is", myFruit["coconut"])   /// coconut price is -99

struct FruitWithSetter {
    var fruitPrice: [String: Int]
    subscript(key: String) -> Int {
        get { fruitPrice[key] ?? -99 }
        set(newValue) { fruitPrice[key] = newValue }
    }
}

var myFruitWithSetter = FruitWithSetter(fruitPrice: [
    "banana": 20,
    "apple": 10,
    "orange": 30
])

print("apple price is", myFruitWithSetter["apple"])       /// apple price is 10
print("coconut price is", myFruitWithSetter["coconut"])   /// coconut price is -99

myFruitWithSetter["coconut"] = 25
print("coconut price is", myFruitWithSetter["coconut"])   /// coconut price is 25

print("=============== Subscript Overloading ===============")
struct StudyGroup {
    var age: [Int]
    var count: Int { age.count }
    subscript(index: Int) -> Int {
        get { index < count && index > -1 ? age[index]: -99}
        set(newValue) { 
            if index < count && index > -1 {
                age[index] = newValue 
            } else {
                print("Out of index")
            }
        }
    }
    subscript(index: Int, multiply: Int) -> Int { index < count && index > -1 ? age[index]*multiply: -99 }
}

var myStudyGroup = StudyGroup(age: [10, 15, 20])
print(myStudyGroup[5])      /// -99
print(myStudyGroup[1])      /// 15
myStudyGroup[3] = 5         /// Out of index
myStudyGroup[2] = 18
print(myStudyGroup[2])      /// 18
print(myStudyGroup[2, 2])   /// 36

print("=============== Type Subscript ===============")
struct Channel {
    static var state :[Bool] = []
    static subscript(value: Bool) -> () { Channel.state.append(value) }
    static subscript(value: Bool, count: Int) -> () {
        if count > 0 {
            for _ in 1...count {
                Channel.state.append(value)
            }
        }
    }
    func showAllState() {
        print(Channel.state)
    }
}
var myChannel = Channel()
Channel[true]
myChannel.showAllState()        /// [t]
Channel[false, 2]               
var myOtherChannel = Channel()
myOtherChannel.showAllState()   /// [t, f, f]
