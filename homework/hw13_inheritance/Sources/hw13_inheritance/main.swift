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
unknownUser.greeting()                              
/// Greeting tempUser

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

/* This class won't work because override property must have
setter or getter
class LazyStudent: Student {
    override var grade = 1.0
}

// This class won't work because super.grade is mutable 
but this override property is read-only(non-mutable)
class LazyStudent : Student {
    override var grade: Double {
        get { super.grade * 0.1 }
    }
}
*/

let someSpecialStudent = SpecialStudent()
print(someSpecialStudent.grade)     /// 3.5
someSpecialStudent.grade = 0.5
print(someSpecialStudent.grade)     /// 4.0

print("=============== Overriding Property Observers ===============")
class ObservedStudent: Student {
    override var grade: Double {
        willSet(newGrade) {
            print("Update grade to \(newGrade)")
        }
        didSet {
            if grade > 3.5 {
                print("Grade A!")
            } else {
                print("Not Grade A!")
            }

        }
    }
}
let someObservedStudent = ObservedStudent()
someObservedStudent.grade = 3.5
/// Upgrade grade to 3.5
/// Not Grade A!

print("=============== Preventing Overrides ===============")
class FinalStudent: Student {
    override final var grade: Double {
        willSet(newGrade) {
            print("Updating grade...")
        }
        didSet {
            print("Grade is updated.")
        }
    }
}

/* This class cant override final property
class FinalFinalStudent: FinalStudent {
    override final var grade: Double {
        willSet(newGrade) {
            print("This class won't work anyway")
        }
        didSet {
            print("Whatever this is")
        }
    }
}
*/
