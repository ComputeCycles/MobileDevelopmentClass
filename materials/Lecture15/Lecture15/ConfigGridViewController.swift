//
//  ConfigGridViewController.swift
//  Lecture15
//
//  Created by Van Simmons on 11/28/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class ConfigGridViewController: UIViewController, GridViewDataSource {

    @IBOutlet weak var gridView: GridView!
    var grid: Grid!
    var config: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (rows, cols) = computeGridSize()
        gridView.rows = rows
        gridView.cols = cols
        gridView.dataSource = self
        grid = Grid(rows: rows, cols: cols)
        if let values = config["contents"] as? [[Int]] {
            values.forEach { (coord:[Int]) in
                let newCell = GridCell(pos: (coord[0], coord[1]),
                                       state: .alive)
                grid[coord[0], coord[1]] = newCell
            }
        }
    }
    
    func cellState(x: Int, y: Int) -> GridCellState? {
        return grid[x, y]?.state
    }
    
    func setCellState(x: Int, y: Int, state: GridCellState) {
        grid[x,y]?.state = state
    }

    func computeGridSize() -> (rows: Int, cols: Int) {
        var max: Int = 1
        if let values = config["contents"] as? [[Int]] {
            max = values.reduce(0) { (currentMax: Int, coordinate: [Int]) -> Int in
                let coordMax = coordinate.reduce(0) { (currentCoordMax: Int, value: Int) -> Int in
                    return value > currentCoordMax ? value : currentCoordMax
                }
                return coordMax > currentMax ? coordMax : currentMax
            }
        }
        return (max*2, max*2)
    }
    
    @IBAction func save(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).engine.grid = grid
        let center = NotificationCenter.default
        let n = Notification(name: Notification.Name(rawValue: ENGINE_UPDATED))
        center.post(n)
    }
}
