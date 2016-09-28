//: Playground - noun: a place where people can play

import UIKit

enum CellState {
    case Alive
    case Empty
    case Born
    case Died
    
    func isAlive() -> Bool {
        switch self {
        case .Alive, .Born:
            return true
        case .Empty, .Died:
            return false
        }
    }
    
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

typealias Position = (x: Int, y: Int)

let offsets: [Position] = [
    (x: -1, y: 1) , (x: 0, y: 1 ), (x: 1, y: 1 ),
    (x: -1, y: 0) ,                (x: 1, y: 0 ),
    (x: -1, y: -1), (x: 0, y: -1), (x: 1, y: -1)
]

var gridRows = 10
var gridCols = 10

struct Cell {
    var pos: Position = (x:0, y:0)
    var state: CellState = .Empty
    var grid: Grid
    
    init(grid:Grid, pos:Position, state: CellState) {
        self.pos = pos
        self.state = state
        self.grid = grid
    }
    
    func neighbors() -> [Position] {
        return offsets.map {
            (x: ((pos.x + $0.x) + grid.cols) % grid.cols,
             y: ((pos.y + $0.y) + grid.rows) % grid.rows)
        }
    }
    
    func numLivingNeighbors () -> Int {
        return neighbors().reduce(0) {
            grid[$1.x,$1.y]?.state == .Alive ? $0 + 1 : $0
        }
    }
    
    func nextState() -> CellState {
        switch numLivingNeighbors() {
        case 2 where self.state.isAlive(),
             3:
            return .Alive
        default:
            return .Empty
        }
    }
    
    
}


class Grid {
    var cells: [Cell] = [Cell]()
    var rows: Int = 0
    var cols: Int = 0
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        for i in 0 ..< cols {
            for j in 0 ..< rows {
                let randomState = arc4random_uniform(3) == 2 ? CellState.Alive :
                    CellState.Empty
                let cell = Cell(grid: self,
                                pos: (i, j),
                                state: randomState)
                cells.append(cell)
            }
        }
    }
   
    subscript (x: Int, y: Int) -> Cell? {
        get {
            guard x >= 0 && y >= 0 else { return nil }
            guard x < cols && y < rows else { return nil }
            return cells[(x*cols) + y]
        }
        set {
            guard let newValue = newValue else { return }
            guard x >= 0 && y >= 0 else { return }
            guard x < cols && y < rows else { return }
            cells[(x*cols) + y] = newValue
        }
    }
}


var grid = Grid(rows: 4, cols: 4)
var cell = grid[1,2]
if var nonOptionalCell = cell {
    nonOptionalCell.pos
    nonOptionalCell.neighbors()
    nonOptionalCell.state = .Empty
    grid[1,2] = nonOptionalCell
}
grid[1,2]?.state

grid[1,2]?.neighbors()
grid[1,2]?.numLivingNeighbors()
grid[1,1]?.state = .Alive
grid[0,2]?.state = .Alive
grid[1,3]?.state = .Alive
grid[0,3]?.state = .Alive
grid[1,2]?.nextState()








