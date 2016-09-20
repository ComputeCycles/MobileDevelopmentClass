//: Playground - noun: a place where people can play

import UIKit

func doubler(i: Int) -> Int {
    return i * 2
}

func tripler(i:Int) -> Int {
    return i * 3
}

doubler(i: 2)

tripler(i: 2)

func multiplier(i: Int, j: Int) -> Int {
    return i * j
}

multiplier(i: 2, j: 2)

var d:(Int) -> Int

d = doubler
d(2)

var t: (Int) -> Int
t = tripler
t(2)

var m  = multiplier
multiplier(i: d(2), j: t(2))
m(d(2),t(2))

func doubler(array: [Int]) -> [Int] {
    var retArray: [Int] = []
    for i in array {
        retArray.append(i*2)
    }
    return retArray
}

doubler(array:[1,2,3,4,5,6,7,8])
var da = doubler(array:)
da([1,2,3])

func sum(array:[Int]) -> Int {
    var retVal: Int = 0
    for i in array {
        retVal += i
    }
    return retVal
}
sum(array:[1,2,3])

var s = sum(array:)
s([1,2,3])

s = { (array: [Int]) -> Int in
    var retVal: Int = 0
    for i in array {
        retVal += i
    }
    return retVal
}
s([1,2,3,4])

var p = { (array: [Int]) -> Int in
    var retVal: Int = 1
    for i in array {
        retVal *= i
    }
    return retVal
}
p([1,2,3,4])


func apply(array:[Int], f:([Int]) -> Int) -> Int {
     return f(array)
}

apply(array:[1,2,3,4], f: sum(array:))
apply(array:[1,2,3,4], f: s)
apply(array:[1,2,3,4], f: p)

apply(array:[1,2,3,4], f: {
    (array: [Int]) -> Int in
    var retVal: Int = 1
    for i in array {
        retVal *= i
    }
    return retVal
})

apply(array:[1,2,3,4]) {
    (array: [Int]) -> Int in
    var retVal: Int = 1
    for i in array {
        retVal *= i
    }
    return retVal
}

var a = [1,2,3,4]

var p2 = { (array: [Int]) -> Int in
    var retVal: Int = 2
    for i in array {
        retVal *= i
    }
    return retVal
}
p2([1,2,3,4])

var product = a.reduce(2) { $0 * $1 }
product

func doubler2(array: [Int]) -> [Int] {
    var retArray: [Int] = []
    for i in array {
        retArray.append(i*2)
    }
    return retArray
}
doubler2(array:[1,2,3,4])

var doubled = [1,2,3,4].map { $0 * 2 }
doubled

func filter2(array: [Int]) -> [Int] {
    var retArray: [Int] = []
    for i in array {
        if i > 4 {
            retArray.append(i)
        }
    }
    return retArray
}
filter2(array:[2,4,6,8])

var filtered = doubled.filter { $0 > 4 }
filtered

var sortedArray = filtered.sorted { $0 > $1 }
sortedArray

var out:[Int] = [1,2,3,4]
    .map { $0 * 2 }
    .filter { $0 > 4 }
    .sorted { $0 > $1 }

out
    
var val = out.reduce(1) { $0 * $1 }
val
