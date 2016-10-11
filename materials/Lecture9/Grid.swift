//
//  Grid.swift
//  Lecture8
//
//  Created by Van Simmons on 10/4/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

class Grid {
    var cells: [GridCell] = [GridCell]()
    var rows: Int = 0
    var cols: Int = 0
    var timer: Timer?
    var timerInterval: TimeInterval = 0 {
        didSet {
            if timerInterval > 0 {
                timer = Timer.scheduledTimer(withTimeInterval: timerInterval,
                                             repeats: true) { (t: Timer) in
                      print("timer went off")
                    let newGrid = self.step()
                }
            }
            else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        for i in 0 ..< cols {
            for j in 0 ..< rows {
                let randomState = GridCellState.Empty
                let cell = GridCell(grid: self,
                                pos: (i, j),
                                state: randomState)
                cells.append(cell)
            }
        }
    }
    
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
    
    func step() -> Grid {
        let newGrid = Grid(rows: rows, cols: cols)
        cells.forEach { (cell) in
            newGrid[cell.pos.x, cell.pos.y]?.state = cell.nextState()
        }
        return newGrid
    }
}











