// HW9: Structures and Classes 
//=================================================================================================================
print("=============== Define Syntax ===============")
struct Course {
    var courseId = "COS2212"
    var credit = 3
    func show() {
        print("Course ID: \(courseId) with \(credit) credits")
    }
}
class Student {
    var favoriteCourse = Course()
    var courseList = [Course]()
    var totalCredit = 0
    var studentId = "6005501686"
}

print("=============== Instances ===============")
let defaultStudent = Student()
let defaultCourse = Course()
print("Default course instance is \(defaultCourse)")    // Course(courseId: "COS2212", credit: 3)
print("Default student instance is \(defaultStudent)")  // file_name.Student

print("=============== Accessing Properties ===============")
print("Default course is", defaultCourse.courseId)  // COS2212
print("Default favorite course is", defaultStudent.favoriteCourse.courseId) // COS2212

print("=============== Memberwise Initializers for Structure Types ===============")
let someCourse = Course(courseId: "COS2102")
someCourse.show()  // Course ID: COS2102 with 3 credits

//let someStudent = Student(studentId: "6005501687")
// Memberwise Initializers cant be used for Structure Types

print("=============== Structures and Enumerations Are Value Types ===============")
// A value type : the value is copied when assign(to a var/const/passed to func)
// All basic types are value types and are implemented as structures
let firstCourse = Course(courseId: "COS1101")
var secondCourse = firstCourse
secondCourse.courseId = "COS1102"
print("First course of 1st year is", terminator: " ")
firstCourse.show()  // COS1101
print("Second course of 1st year is", terminator: " ")
secondCourse.show() // COS1102

enum CourseWithEnum {
    case cos1101, cos1102, cos1103, cos2101, cos2102
    mutating func pickOOP() {
        self = .cos2102
    }
}
var myFirstFavoriteCourse = CourseWithEnum.cos1103
let mySecondFavoriteCourse = myFirstFavoriteCourse
print("Before:")
print("1st favorite course: \(myFirstFavoriteCourse)")      // cos1103
print("2nd favorite course: \(mySecondFavoriteCourse)")     // cos1103
myFirstFavoriteCourse.pickOOP()
print("After:")
print("1st favorite course: \(myFirstFavoriteCourse)")      // cos2102
print("2nd favorite course: \(mySecondFavoriteCourse)")     // cos1103

print("=============== Classes Are Reference Types ===============")
let someStudent = Student()
someStudent.courseList.append(someStudent.favoriteCourse)
let anyStudent = someStudent
print("Before:")
print("someStudent's courseList: \(someStudent.courseList)")    // [COS2212]
print("anyStudent's courseList: \(anyStudent.courseList)")      // [COS2212]

anyStudent.courseList.append(Course(courseId: "COS1103"))
print("After:")
print("someStudent's courseList: \(someStudent.courseList)")    // [COS2212, COS1103]
print("anyStudent's courseList: \(anyStudent.courseList)")      // [COS2212, COS1103]

print("=============== Identity Operator ===============")
if someStudent === anyStudent {
    print("someStudent and anyStudent refer to the same instance")
}

let someStudent1 = Student()
let someStudent2 = Student()
if someStudent1 !== someStudent2 {
    print("someStudent and someStudent2 do not refer to the same instance")
}
/*  
    Even though someStudent1's properties and someStudent2's properties 
    have the same value, Thay do not refer to the same instance!
*/

/*  '==' can not be applied
if someStudent1 == someStudent2 {
    print("a")
}
*/

