import App
import Vapor

//Model
class Person {
    enum InvalidInput: Error {
            case invalidAge
            case invalidWeight
            case invalideHeight
            case invalidID
    }   
    var name: String
    var id: String
    var age: Int
    var weight: Double
    var height: Double
    init(name: String, id: String, age: Int, weight: Double, height: Double) throws { 
        if (age <= 0) {
            throw InvalidInput.invalidAge
        }
        if (weight <= 0.0) {
            throw InvalidInput.invalidWeight
        }
        if (height <= 0.0) {
            throw InvalidInput.invalideHeight
        }
        self.name = name 
        self.id = id
        self.age = age
        self.weight = weight
        self.height = height
    }
    deinit {
        print("Checkout")
        showData()
    }
    func showData() {
        print("Name: \(name)")
        print("ID: \(id)")
        print("Age: \(age) yrs")
        print("Weight: \(weight) kg.")
        print("Height: \(height) m.")
    }
}

class MedicalWorker: Person {
    var jobTitle: String

    init(name: String, id: String, age: Int, weight: Double, height: Double, jobTitle: String) throws {
        self.jobTitle = jobTitle
        try super.init(name: name, id: id, age: age, weight: weight, height: height)
    }
    override func showData() {
        super.showData()
        print("Job title: \(jobTitle)")
    }
}

class Vulnerable: Person {
    var isElderly: Bool { super.age > 64 ? true: false }
    var isObesed: Bool {
        let bmi = super.weight / super.height / super.height 
        let isObesed = bmi > 30 ? true: false
        return isObesed
    }
    override func showData() {
        super.showData()
        print("Obesity: \(isObesed ? "Yes": "No")")
        print("Elderly: \(isElderly ? "Yes": "No")")
    }
}

class Queue {
    var persons: [Person] = []

    subscript(index: Int) -> Person? {
        if (index < 0 || index >= persons.count) {
            return nil
        }
        return persons[index]
    }
}

class PriorityQueues {
    static let maximumPriority = 4
    static var queues: [Queue] = []
    static subscript(index: Int) -> [Person]? {
        if (index < 0 || index > PriorityQueues.maximumPriority ) {
            return nil
        }
        return PriorityQueues.queues[index].persons
    }

    init() {
        for _ in 0 ... PriorityQueues.maximumPriority {
            PriorityQueues.queues.append(Queue())
        }
    }
    func getAll() -> [Person] {
        var allPerson: [Person] = []
        for queue in PriorityQueues.queues {
            for person in queue.persons.reversed() {
                allPerson.append(person)
            }
        }
        return allPerson
    }
    
    func add(_ person: Person) {
        var priority: Int {
            var priority = 0
            if let vulnerable = person as? Vulnerable {
                if vulnerable.isObesed { priority += 1 }
                if vulnerable.isElderly { priority += 2 }
            }
            else if let _ = person as? MedicalWorker {
                priority += 4
            }
            return priority 
        }
        PriorityQueues.queues[priority].persons.append(person)
    }

    func get(by id: String) -> Person? {
        for queue in PriorityQueues.queues {
            for person in queue.persons {
                if person.id == id {
                    print(person)
                    return person
                }
            }
        }
        return nil
    }

    func remove(by id: String) -> Person? {
        for queue in PriorityQueues.queues {
            if let index = queue.persons.firstIndex(where: { $0.id == id }) {
                let removePerson = queue.persons.remove(at: index)
                return removePerson
            }
        }
        return nil
    }
}

let initPQ = PriorityQueues()

struct PersonReqBody: Content {
    let name: String
    let id: String
    let age: Int
    let weight: Double
    let height: Double
    let medicalJob: String?
}
struct PersonResBody: Content {
    let name: String
    let id: String
    let age: Int
    let weight: Double
    let height: Double
    let medicalJob: String?
    let isElderly: Bool
    let isObesed: Bool
}

struct ResMessage: Content {
    var response: [PersonResBody?]
}

let app = Application()
defer { app.shutdown() }

func routes(_ app: Application) throws {

    app.get("hello") { req -> String in
        return "Hello, World"
    }

    app.get("api", "persons") { req -> ResMessage in 
        let persons = initPQ.getAll()
        var resMessage = ResMessage(response: [])
        for person in persons {
            var medicalJob: String = "-"
            var isElderly: Bool = false
            var isObesed: Bool = false
            if let medicalWorker = person as? MedicalWorker {
                medicalJob = medicalWorker.jobTitle
            } else if let vulnerable = person as? Vulnerable {
                isElderly = vulnerable.isElderly
                isObesed = vulnerable.isObesed
            }
            let personResBody = PersonResBody(
                name: person.name, 
                id: person.id, 
                age: person.age, 
                weight: person.weight, 
                height: person.height, 
                medicalJob: medicalJob,
                isElderly: isElderly, 
                isObesed: isObesed)
            resMessage.response.append(personResBody)
        }

        return resMessage
    }

    app.put("api", "person", "checkout" ) { req -> ResMessage in
        var checkedOut: PersonResBody?
        for queue in PriorityQueues.queues.reversed() {
            if queue.persons.isEmpty {
                continue
            }
            let person = queue.persons.remove(at: 0)
            var medicalJob: String = "-"
            var isElderly: Bool = false
            var isObesed: Bool = false
            if let medicalWorker = person as? MedicalWorker {
                medicalJob = medicalWorker.jobTitle
            } else if let vulnerable = person as? Vulnerable {
                isElderly = vulnerable.isElderly
                isObesed = vulnerable.isObesed
            }
            checkedOut = PersonResBody(
                name: person.name, 
                id: person.id, 
                age: person.age, 
                weight: person.weight, 
                height: person.height, 
                medicalJob: medicalJob,
                isElderly: isElderly, 
                isObesed: isObesed)
            break
        }

        let resMessage = ResMessage(response: [checkedOut])
        return resMessage


    }

    app.get("api", "persons", ":id") { req -> ResMessage in
        let id = req.parameters.get("id")!
        if let person = initPQ.get(by: id) {
            print("create response")
            var medicalJob: String = "-"
            var isElderly: Bool = false
            var isObesed: Bool = false
            if let medicalWorker = person as? MedicalWorker {
                medicalJob = medicalWorker.jobTitle
            } else if let vulnerable = person as? Vulnerable {
                isElderly = vulnerable.isElderly
                isObesed = vulnerable.isObesed
            }
            let response = PersonResBody(
                name: person.name, 
                id: person.id, 
                age: person.age, 
                weight: person.weight, 
                height: person.height, 
                medicalJob: medicalJob,
                isElderly: isElderly, 
                isObesed: isObesed)
            return ResMessage(response: [response])
        }
        return ResMessage(response: [nil])
    }

    app.post("api", "persons") { req -> HTTPStatus in 
        let person = try req.content.decode(PersonReqBody.self)
        do {
            if let _ = initPQ.get(by: person.id) {
                throw Person.InvalidInput.invalidID
            }
            if let job = person.medicalJob {
                try initPQ.add(MedicalWorker(
                    name: person.name, 
                    id: person.id, 
                    age: person.age, 
                    weight: person.weight, 
                    height: person.height, 
                    jobTitle: job)) 
            } else {
                let bmi = person.weight / person.height / person.height 
                if bmi > 30 || person.age > 64 {
                    try initPQ.add(Vulnerable(
                        name: person.name, 
                        id: person.id, 
                        age: person.age, 
                        weight: person.weight, 
                        height: person.height)) 
                } else {
                    try initPQ.add(Person(
                        name: person.name, 
                        id: person.id, 
                        age: person.age, 
                        weight: person.weight, 
                        height: person.height)) 
                }
            }
        } catch Person.InvalidInput.invalidID {
            print("id: \(person.id) is already taken")
        } catch Person.InvalidInput.invalidAge {
            print("Invalid age")
            return HTTPStatus.badRequest
        } catch Person.InvalidInput.invalideHeight {
            print("Invalid height")
            return HTTPStatus.badRequest
        } catch Person.InvalidInput.invalidWeight {
            print("Invalid weight")
            return HTTPStatus.badRequest
        }

        return HTTPStatus.ok
    }
}

func configure(_ app: Application) throws {
    try routes(app)
}

try configure(app)
try app.run()
