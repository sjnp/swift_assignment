// HW11: Methods
//=================================================================================================================
print("=============== Instance Methods And Self Property ===============")
class GreetingWithClass {
    let greeting = "Hello, "
    var name = "World"
    func greet(_ name: String) {
        self.name = name
        print(greeting + self.name)
    }
}
let greetingJohn = GreetingWithClass()
greetingJohn.greet("John")      // Hello, John

print("=============== Modifying Value Types from Instance Methods ===============")
struct GreetingWithStruct {
    let greeting = "Hi, "
    var name = "World"

    /*  This func can't be done, have to change name value directly
        via instance.name = .... or using mutating func! 
    func greet(_ name: String) {
        self.name = name
        print(greeting + self.name)
    }
    */

    mutating func greet(_ name: String) {
        self.name = name
        print(greeting + self.name)
    }
}
var greetingSarah = GreetingWithStruct()
greetingSarah.greet("Sarah")    // Hi, Sarah

print("=============== Type Methods ===============")
enum State : String {
    case on, off

    mutating func toggleState() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

class IOchannel {
    static let maxChannel: Int = 5
    static var allPinState: [State] = []
    init() {
        if IOchannel.allPinState.count == 0 {
            for _ in 1...IOchannel.maxChannel {
                IOchannel.allPinState.append(State.off)
            }
        }
    }
    static func disconnectAllPins() {
        for pin in 0..<IOchannel.maxChannel {
            if IOchannel.allPinState[pin] == .on {
                IOchannel.allPinState[pin].toggleState()
            }
        }
        print("Disconnected all devices successfully")
    }
    static func connect(to pin: Int) {
        if pin < 0 || pin >= IOchannel.maxChannel {
            print("Pin number must be 0...\(IOchannel.maxChannel-1)")
        } else { 
            if IOchannel.allPinState[pin] == .off {
                IOchannel.allPinState[pin].toggleState()
                print("Connected successfully at pin#\(pin)")
            } else {
                print("Pin#\(pin) is already occupied, please try another pin")
            }
        } 
    }
    func showAllPins() {
        print("IO pins: ", terminator: "")
        for pin in IOchannel.allPinState {
            print(pin.rawValue, terminator: " ")
        }
        print("")
    }
}

class Device {
    var ioChannel = IOchannel()
    var desiredPin : Int = 0
    func connect() {
        IOchannel.connect(to: desiredPin)
    }
    func connect(to pin: Int) {
        desiredPin = pin
        connect()
    }
}
let ioChannel = IOchannel()
ioChannel.showAllPins()             // IO pins: off off off off off
let lightSensor = Device()
lightSensor.connect()               // Connected successfully at pin#0
ioChannel.showAllPins()             // IO pins: on off off off off
let soundSensor = Device()
soundSensor.connect()               // Pin#0 is already occupied, please try another pin
soundSensor.connect(to: 5)          // Pin number must be 0...4
soundSensor.connect(to: 4)          // Connected succesfully at pin#4
lightSensor.ioChannel.showAllPins() // IO pins: on off off off on
soundSensor.ioChannel.showAllPins() // IO pins: on off off off on
IOchannel.disconnectAllPins()       // Disconnected all devices successfully
ioChannel.showAllPins()             // IO pins: off off off off off
