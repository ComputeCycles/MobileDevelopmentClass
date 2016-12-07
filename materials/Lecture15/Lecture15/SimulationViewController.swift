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
    var engine: Engine = (UIApplication.shared.delegate as! AppDelegate).engine
    var defaults: UserDefaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gridView.dataSource = self
        engine.delegate = self
        self.gridView.rows = Int(defaults.value(forKey: "Rows") as? Float ?? 5.0)
        self.gridView.cols = Int(defaults.value(forKey: "Columns") as? Float ?? 5.0)
        let center = NotificationCenter.default
        center.addObserver(forName: NSNotification.Name(rawValue:ENGINE_UPDATED),
                           object: nil,
                           queue: nil) { (n: Notification) -> Void in
                            self.gridView.rows = self.engine.grid.rows
                            self.gridView.cols = self.engine.grid.cols
                            self.gridView.setNeedsDisplay()
        }
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
            self.gridView.isUserInteractionEnabled = false
            engine.timerInterval = 0.05
        } else {
            self.gridView.isUserInteractionEnabled = true
            engine.timerInterval = 0.0
        }
    }
}

