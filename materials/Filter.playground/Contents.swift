//: Playground - noun: a place where people can play

import UIKit

var grid = [[Bool]](repeating: [Bool](repeating: false, count: 8), count: 10)

(0 ..< grid.count).forEach { i in
    (0 ..< grid[i].count).forEach { j in
        grid[i][j] = arc4random_uniform(2) == 1
    }
}

grid

let number = (0 ..< grid.count).reduce(0) { (accum, row) in
    return accum + grid[row].filter { !$0 }.count
}

number
