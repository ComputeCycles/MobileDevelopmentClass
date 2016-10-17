//
//  Engine.swift
//  Lecture9
//
//  Created by Van Simmons on 10/11/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import Foundation

protocol EngineDelegate {
    func engine(engine: Engine, didUpdateGrid: Grid)
}

class Engine {

    var rows: Int = 0
    var cols: Int = 0
    var grid: Grid! {
        didSet {
            rows = grid.rows
            cols = grid.cols
        }
    }
    
    var delegate: EngineDelegate?
    
    var updateClosure: ((Grid) -> Void)?
    var timer: Timer?
    var timerInterval: TimeInterval = 0 {
        didSet {
            if timerInterval > 0 {
                timer = Timer.scheduledTimer(
                    withTimeInterval: timerInterval,
                    repeats: true) { (t: Timer) in
                        print("timer went off")
                        self.step()
                        // self.updateClosure?(self.grid)
//                        self.delegate?.engine(engine: self,
//                                              didUpdateGrid: self.grid)
                        let nc = NotificationCenter.default
                        let name = Notification.Name(rawValue: "EngineUpdate")
                        let n = Notification(name: name,
                                             object: nil,
                                             userInfo: ["grid" : self.grid])
                        nc.post(n)
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
        self.grid = Grid(rows: rows, cols: cols)
    }
    
    func step() {
        let newGrid = Grid(rows: rows, cols: cols)
        grid.cells.forEach { (cell) in
            newGrid[cell.pos.x, cell.pos.y]?.state = cell.nextState()
        }
        grid = newGrid
    }

}
