// HW13: Inheritance
//=================================================================================================================
print("=============== Defining a base class ===============")
class User {
    var username = "tempUser"
    var password = "1234"
    func greeting() { print("Greeting, \(username)")}
}

print("=============== Subclassing ===============")
class Customer: User {
    var orderID = "XXXX"
    func showOrder() {
        greeting()
        print("Order: \(orderID)")
    }
}

class SpecialCustomer: Customer {
    var discount = 10
    func showDiscount() {
        showOrder()
        print("Discount: \(discount)%")
    }

}
let unknownUser = User()
unknownUser.greeting()                              /// Greeting tempUser

let unknownCustomer = Customer()
unknownCustomer.username = "abcd"                   
unknownCustomer.showOrder()
/// Greeting abcd
/// Order: XXXX

let unknownSpecialCustomer = SpecialCustomer()
unknownSpecialCustomer.username = "john123"
unknownSpecialCustomer.showDiscount()
/// Greeting john123
/// Order: XXXX
/// Discount: 10%

print("=============== Overriding Methods ===============")
class Admin: User {
    var adminID = "0000"
    override func greeting() { 
        print("Admin: \(adminID)")
        super.greeting()
    }
}
let unknownAdmin = Admin()
unknownAdmin.greeting()
/// Admin: 0000
/// Greeting, tempUser

print("=============== Overriding Property ===============")
class Student {
    /// Stored Property
    var grade = 3.0
}
class SpecialStudent: Student {
    var specialGrade = 0.5
    /// Computed Property
    override var grade: Double {
        get { super.grade+specialGrade }
        set(newValue) { specialGrade += newValue }
    }
}

let someSpecialStudent = SpecialStudent()
print(someSpecialStudent.grade)     /// 3.5
someSpecialStudent.grade = 0.5
print(someSpecialStudent.grade)     /// 4.0

print("=============== Overriding Property Observers ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")

print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
print("=============== Defining a base class ===============")
