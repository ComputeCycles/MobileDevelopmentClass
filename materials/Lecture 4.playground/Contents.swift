//: Playground - noun: a place where people can play

import UIKit

var str: String = "c"

switch str {
    
case "a":
    print("got an a")

case "b"..."f":
  print("between b and f")
    
default:
    print("something else")
}

var pos = (3, 2)
var col = pos.0

var otherPos = (x:3, y:2)
var otherRow = otherPos.y

var num: Int? = nil
num = 10
//num = nil
if let x = num {
    x + 1
    print("got a num")
}
//let numBang = num!
//num + 1

let d:[String:Int] = ["a": 1, "b": 2, "c": 3]
let v = d["47"]
let v1 = d["a"]
//v1 + 1

if num == nil {
    print ("num is nil")
}
else if num == 10 {
    print ("num is 10")
}


