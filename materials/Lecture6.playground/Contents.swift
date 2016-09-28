//: Playground - noun: a place where people can play

import UIKit
import Foundation

var anArrayReference = NSMutableArray(array: [1,2,3,4])
var arr = NSMutableArray(array: [1,2,3,4])

//anArrayReference.add(5)
arr

var anArray = [1,2,3,4]
var otherArray = anArray

//anArray.append(5)
otherArray

if anArray == otherArray {
    print ("They're =")
}

if anArrayReference === arr {
    print ("they are the same reference")
}

if anArrayReference == arr {
    print ("they are the same value")
}

enum CellState {
    case Alive
    case Empty
    case Born
    case Died
    
    func displayValue() -> String {
        switch self {
        case .Alive:
            return "Alive"
        case .Empty:
            return "Empty"
        case .Born:
            return "Born"
        case .Died:
            return "Died"
        }
    }
}

var state = CellState.Alive
state.displayValue()

typealias Position = (x: Int, y: Int)

var gridRows = 4
var gridCols = 4

var quotient = 3 / gridRows
var mod = (3 + gridRows) % gridRows

let offsets: [Position] = [
    (x: -1, y: 1) , (x: 0, y: 1 ), (x: 1, y: 1 ),
    (x: -1, y: 0) ,                (x: 1, y: 0 ),
    (x: -1, y: -1), (x: 0, y: -1), (x: 1, y: -1)
]

class Cell {
    var pos: Position = (x:0, y:0)
    var state: CellState = .Empty

    init(pos:Position, state: CellState) {
        self.pos = pos
        self.state = state
    }
    
    func neighbors() -> [Position] {
        return offsets.map {
            (x: ((pos.x + $0.x) + gridCols) % gridCols,
             y: ((pos.y + $0.y) + gridRows) % gridRows)
        }
    }
}

//let cell = Cell()
let cell = Cell(pos:(x:0, y:0), state: .Empty)
print("\(cell.neighbors())")

struct Grid {
    var cells: [[Cell]] = [[Cell]]()
}

var positions: [Position] = [Position]()
var otherPositions: Array<Position> = Array<Position>()

public enum Result<T> {
    case Success(() -> T)
    case Failure(NSError)
    
    public func then(nextOperation:(T) -> Result<T>) -> Result<T> {
        switch self {
        case let .Failure(error):       return .Failure(error)
        case let .Success(something):   return nextOperation(something())
        }
    }
}

public enum Optional<T> {
    case Some(T)
    case None
}

var oString: String?
var o: Optional<String> = Optional.Some("String")
var otherO: Optional<String> = Optional.None






