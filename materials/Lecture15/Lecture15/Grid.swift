//
//  Grid.swift
//  Lecture15
//
//  Created by Van Simmons on 11/14/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

//
//  Grid.swift
//  Lecture8
//
//  Created by Van Simmons on 10/4/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

typealias Position = (x: Int, y: Int)

private let offsets: [Position] = [
    (x: -1, y: 1) , (x: 0, y: 1 ), (x: 1, y: 1 ),
    (x: -1, y: 0) ,                (x: 1, y: 0 ),
    (x: -1, y: -1), (x: 0, y: -1), (x: 1, y: -1)
]

struct GridCell {
    var pos: Position
    var state: GridCellState
    var grid: Grid
    
    init(grid:Grid, pos:Position, state: GridCellState) {
        self.pos = pos
        self.state = state
        self.grid = grid
    }
    
    var neighbors: [Position] {
        get {
            return offsets.map { (offset: Position) in
                let offset: Position =
                    (x: ((self.pos.x + offset.x) + grid.cols) % grid.cols,
                     y: ((self.pos.y + offset.y) + grid.rows) % grid.rows)
                return offset
            }
        }
    }
    func forNeighbors() -> [Position] {
        var neighbors: [Position] = []
        for offset in offsets {
            let neighbor = (x: ((self.pos.x + offset.x) + grid.cols) % grid.cols,
                            y: ((self.pos.y + offset.y) + grid.rows) % grid.rows)
            neighbors.append(neighbor)
        }
        return neighbors
    }
    func numLivingNeighbors () -> Int {
        return neighbors.reduce(0) {
            grid[$1.x,$1.y]?.state == .alive ? $0 + 1 : $0
        }
    }
    func forNumLivingNeighbors () -> Int {
        var returnValue:Int = 0
        for neighbor in neighbors {
            returnValue = grid[neighbor.x, neighbor.y]?.state == .alive ? returnValue + 1 : returnValue
        }
        return returnValue
    }
    
    func nextState() -> GridCellState {
        switch numLivingNeighbors() {
        case 2 where self.state.isAlive(),
             3:
            return .alive
        default:
            return .empty
        }
    }
}

class Grid {
    var cells: [GridCell] = [GridCell]()
    var rows: Int = 0
    var cols: Int = 0
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        (0 ..< cols ).forEach { i in
            for j in 0 ..< rows {
                let randomState = GridCellState.empty
                let cell = GridCell(grid: self,
                                    pos: (i, j),
                                    state: randomState)
                cells.append(cell)
            }
        }
    }
    
    // let someGridCell = grid[col, row]
    // grid[col, row] = someGridCell
    subscript (x: Int, y: Int) -> GridCell? {
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

protocol EngineDelegate {
    func engineDidUpdate(engine: Engine)
}

class Engine {
    var grid: Grid
    var delegate: EngineDelegate?
    
    var updateClosure: ((Grid) -> Void)?
    var timer: Timer?
    var timerInterval: TimeInterval = 0.0 {
        didSet {
            if timerInterval > 0.0 {
                timer = Timer.scheduledTimer(
                    withTimeInterval: timerInterval,
                    repeats: true) { (t: Timer) in
                        self.step()
                }
            }
            else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    init(rows: Int, cols: Int) {
        self.grid = Grid(rows: rows, cols: cols)
    }
    
    func step() {
        let newGrid = Grid(rows: grid.rows, cols: grid.cols)
        grid.cells.forEach { (cell) in
            newGrid[cell.pos.x, cell.pos.y]?.state = cell.nextState()
        }
        grid = newGrid
        // updateClosure?(self.grid)
        delegate?.engineDidUpdate(engine: self)
        //  let nc = NotificationCenter.default
        //  let name = Notification.Name(rawValue: "EngineUpdate")
        //  let n = Notification(name: name,
        //                       object: nil,
        //                       userInfo: ["grid" : self.grid])
        //                       nc.post(n)
    }
}

