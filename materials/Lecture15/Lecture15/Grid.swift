//
//  Grid.swift
//  Lecture15
//
//  Created by Van Simmons on 11/14/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

//
//  Grid.swift
//  Lecture15
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
    
    init(grid:Grid, pos:Position, state: GridCellState) {
        self.pos = pos
        self.state = state
    }
}

struct Grid {
    var cells: [GridCell] = [GridCell]()
    var rows: Int = 0
    var cols: Int = 0
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        (0 ..< cols ).forEach { i in
             (0 ..< rows).forEach { j in
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
    
    private func neighborsOf(cell: GridCell) -> [Position] {
        return offsets.map { (offset: Position) in
            let offset: Position =
                (x: ((cell.pos.x + offset.x) + cols) % cols,
                 y: ((cell.pos.y + offset.y) + rows) % rows)
            return offset
        }
    }

    private func numLivingNeighborsOf(cell: GridCell) -> Int {
        return neighborsOf(cell: cell).reduce(0) {
            (self[$1.x,$1.y]?.state.isAlive())! ? $0 + 1 : $0
        }
    }
    
    func nextStateOf(cell: GridCell) -> GridCellState {
        switch numLivingNeighborsOf(cell: cell) {
        case 2 where cell.state.isAlive(),
             3:
            return cell.state.isAlive() ? .alive : .born
        default:
            return cell.state.isAlive() ? .died : .empty
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
        var newGrid = Grid(rows: grid.rows, cols: grid.cols)
        grid.cells.forEach { (cell) in
            newGrid[cell.pos.x, cell.pos.y]?.state = grid.nextStateOf(cell: cell)
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

