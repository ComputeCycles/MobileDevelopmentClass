//
//  Grid.swift
//  Lecture8
//
//  Created by Van Simmons on 10/4/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

class Grid {
    var cells: [Cell] = [Cell]()
    var rows: Int = 0
    var cols: Int = 0
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        for i in 0 ..< cols {
            for j in 0 ..< rows {
//                let randomState = arc4random_uniform(3) == 2 ? CellState.Alive :
//                    CellState.Empty
                let randomState = CellState.Empty
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
