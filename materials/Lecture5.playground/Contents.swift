import Foundation

struct PhoneNumber {
    var countryCode: Int
    var areaCode: Int
    var exchange: Int
    var number: Int
    
    func displayValue() -> String {
        return "+\(countryCode) (\(areaCode)) \(exchange) - \(number)"
    }
}

let aPhone = PhoneNumber(countryCode: 1,
                         areaCode: 615,
                         exchange: 555,
                         number: 1212)
aPhone.displayValue()

class Person: NSObject {
    var firstName: String?
    var lastName: String?
    var email: String?
    var birthDateComponents: DateComponents?
    var phoneNumber: PhoneNumber?
    
    init(firstName: String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func displayName() -> String {
        return "\(lastName!), \(firstName!)"
    }
    
    func birthDate() -> Date {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.date(from: birthDateComponents!)
        return date!
    }
    
    func age() -> TimeInterval {
        let refDate = birthDate().timeIntervalSince1970
        let interval = Date().timeIntervalSince1970 - refDate
        return interval / (86400.0*365.0)
    }
}

var david = Person(firstName: "David", lastName: "Barber")
david.displayName()

var monica = Person(firstName: "Monica",
                    lastName: "Baker")
monica.email = "monica.baker@gmail.com"
monica.birthDateComponents = DateComponents()
monica.phoneNumber = PhoneNumber(countryCode: 1,
                                 areaCode: 615,
                                 exchange: 555,
                                 number: 1212)
monica.birthDateComponents?.month = 9
monica.birthDateComponents?.day = 19
monica.birthDateComponents?.year = 1986

monica.displayName()
monica.age()
monica.phoneNumber?.displayValue()

func displayName(person: Person) -> String {
    return person.displayName()
}

displayName(person: monica)

var anArray: NSArray = NSArray(array: [1,2,3,4])

var anotherArray:NSArray = anArray as NSArray

anArray.adding(5)
anotherArray


