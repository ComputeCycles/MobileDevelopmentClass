//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Goodbye, playground"

var num = 7

let newStr = str.uppercased()

str = str.replacingOccurrences(of: "Goodbye", with: "Sayanara")

var myBool = true

let someDouble = 18.478963

let doubleSomeDOuble = someDouble * 2.0

let someString = newStr + " " + str

let someNum = Double(num) + someDouble

let someArray = [1, 2, 3, 4, 5]
let someOtherArray = [6, 7, 8, 9, 10]
let combinedArray = someArray + someOtherArray

var dict = ["a": 1, "b": 2, "c": 3]
let x = dict["c"]

dict["d"] = 4
let desc = "\(dict)"

var view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 100.0))
view.backgroundColor = UIColor.blue

if dict["d"] == 5 {
    print ("got it")
}
else {
    print ("didn't get it")
}

for i in someArray {
    print ("\(i)")
}

var i = 0
while i < 10 {
    i += 1
}

// This is a single line comment
/*
 this is a multiline comment
 */
i = 0
repeat {
    i += 1
} while i < 10

