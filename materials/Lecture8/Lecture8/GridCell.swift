//
//  GridCell.swift
//  Lecture8
//
//  Created by Van Simmons on 10/4/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

typealias Position = (x: Int, y: Int)

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

private let offsets: [Position] = [
    (x: -1, y: 1) , (x: 0, y: 1 ), (x: 1, y: 1 ),
    (x: -1, y: 0) ,                (x: 1, y: 0 ),
    (x: -1, y: -1), (x: 0, y: -1), (x: 1, y: -1)
]

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

