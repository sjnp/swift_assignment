// HW17: Error Handling
//=================================================================================================================
print("=============== Representing and throwing errors ===============")
/// 'enum' is well suited for creating a group of error conditions
/// errors must be conform to 'Error' protocol

enum ConnectionError: Error {
    case invalidAddress
    case highLatency
    case outOfSocket
}

// throw ConnectionError.outOfSocket
// The above line will show the error in the terminal:
// Error raised at the top level: filename.ConnectionError.outOfSocket: file Swift/ErrorType.swift, line 200

enum AuthenticationError: Error {
    case wrongUsername
    case wrongPassword
}

print("=============== Propagating errors using throwing functions ===============")
// use 'throws' after function parameters
// func throwingErrorFunc() throws -> String? { }
class Admin {
    let adminUsername = "admin"
    let adminPassword = "1234"

    func login(withUsername username: String, withPassword password: String) throws {
        guard adminUsername == username else {
            throw AuthenticationError.wrongUsername
        }

        guard adminPassword == password else {
            throw AuthenticationError.wrongPassword
        }
    }
}

func login(withPassword password: String) throws {
    let username = "admin"
    let admin = Admin()
    try admin.login(withUsername: username, withPassword: password)
}

if let _ = try? login(withPassword: "1234") {
    print("Login successful")
} else {
    print("Login failed: wrong password")
}
// Login successful

if let _ = try? login(withPassword: "5678") {
    print("Login successful")
} else {
    print("Login failed: wrong password")
}
// Login failed: wrong password


print("=============== Handling errors using do-catch ===============")
let somePerson = Admin()
print(type(of: somePerson.login))                                   // (String, String) throws -> ()

func login(withClosure: (String, String) throws -> (), username: String, password: String) {
    do {
        try withClosure(username, password)
        print("Login succesful")
    } catch AuthenticationError.wrongUsername {
        print("Invalid username")
    } catch AuthenticationError.wrongPassword {
        print("Invalid password")
    } catch {
        print("Unexpected error: \(error)")
    }
}

login(withClosure: somePerson.login, username: "admin", password: "1234")   // Login successful
login(withClosure: somePerson.login, username: "", password: "")            // Invalid username
login(withClosure: somePerson.login, username: "admin", password: "")       // Invalid password

print("=============== Coverting errors to optional values ===============")
struct LoginAttempt {
    static var loginCount = 0
    init(username: String, password: String) throws {
        let admin = Admin()
        try admin.login(withUsername: username, withPassword: password) 
        LoginAttempt.loginCount = LoginAttempt.loginCount + 1
    }
}
let firstTry = try? LoginAttempt(username: "", password: "") 
print(firstTry)                                                     // nil
print(LoginAttempt.loginCount)                                      // 0
let secondTry = try? LoginAttempt(username: "admin", password: "1234")
print(secondTry)                                                    // Optional(filename.LoginAttempt())
print(LoginAttempt.loginCount)                                      // 1

print("=============== Disabling error propagation ===============")
let thirdTry = try! LoginAttempt(username: "admin", password: "1234")
print(thirdTry)                                                     // LoginAttempt()
print(LoginAttempt.loginCount)                                      // 2

// let forthTry = try! LoginAttempt(username: "", password: "1234")
// runtime error: AuthenticationError.wrongUsername

print("=============== Defer statements ===============")
func bruteforcePassword(startWith base: UInt) {
    var baseNumber = base
    defer {
        print("Password is \(baseNumber)")
    }
    while (try? LoginAttempt(username: "admin", password: String(baseNumber))) == nil {
        baseNumber = baseNumber + 1
    }
}
bruteforcePassword(startWith: 1000)      // Password is 1234   