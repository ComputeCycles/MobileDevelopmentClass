//
//  SecondViewController.swift
//  Lecture15
//
//  Created by Van Simmons on 11/7/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController,
    EngineDelegate, GridViewDataSource {

    @IBOutlet weak var gridView: GridView!
    var engine: Engine = Engine(rows: 10, cols: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gridView.dataSource = self
        engine.delegate = self
    }

    //MARK: EngineDelegateProtocol
    func engineDidUpdate(engine: Engine) {
        gridView.setNeedsDisplay()
    }
    
    //MARK: GridViewDataSourceProtcol
    func cellState (x: Int, y: Int) -> GridCellState? {
        return engine.grid[x, y]?.state
    }
    
    func setCellState (x: Int, y: Int, state: GridCellState) -> Void {
        engine.grid[x, y]?.state = state
    }
    
    //MARK: Actions
    @IBAction func step(_ sender: Any) {
        engine.step()
    }

    @IBAction func toggle(_ sender: UISwitch) {
        if sender.isOn {
            engine.timerInterval = 0.5
        } else {
            engine.timerInterval = 0.0
        }
    }
}

