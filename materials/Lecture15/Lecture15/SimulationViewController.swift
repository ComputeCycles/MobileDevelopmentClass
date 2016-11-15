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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: EngineDelegateProtocol
    func engine(engine: Engine, didUpdateGrid: Grid) {
        
    }
    
    //MARK: GridViewDataSourceProtcol
    func cellState (x: Int, y: Int) -> GridCellState? {
        return engine.grid![x, y]?.state
    }
    
    func setCellState (x: Int, y: Int, state: GridCellState) -> Void {
        engine.grid![x, y]?.state = state
    }
    

}

