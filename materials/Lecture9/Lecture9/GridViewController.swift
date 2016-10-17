//
//  ViewController.swift
//  Lecture9
//
//  Created by Van Simmons on 10/10/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class GridViewController: UIViewController, EngineDelegate, GridViewDataSource {

    var engine = Engine(rows: 10, cols: 10)
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gridView.dataSource = self
        engine.updateClosure = { grid in
            self.gridView.setNeedsDisplay()
        }
        engine.delegate = self
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(self,
                       selector: #selector(engineUpdate(notification:)),
                       name: name,
                       object: nil)
    }

    var rows: Int {
        get { return engine.rows }
        set(newValue) { engine.rows = newValue }
    }
    var cols: Int {
        get { return engine.cols }
        set(newValue) { engine.cols = newValue }
    }
    
    subscript (x: Int, y: Int) -> GridCellState? {
        get { return engine.grid![x,y]?.state }
        set (newValue) {
            guard let newValue = newValue else { return }
            var gridCell = engine.grid[x,y]
            gridCell?.state = newValue
            engine.grid[x,y] = gridCell
        }
    }

    func engineUpdate(notification: Notification) {
        self.gridView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engine(engine:Engine, didUpdateGrid grid:Grid) {
        self.gridView.setNeedsDisplay()
    }
    
    @IBAction func step(sender:AnyObject) {
        engine.step()
        gridView.setNeedsDisplay()
    }
    
    @IBAction func start(sender:UIButton) {
        if sender.tag == 0 {
            engine.timerInterval = 1.0
            sender.setTitle("Stop",for:.normal)
            sender.tag = 1
        }
        else {
            engine.timerInterval = 0.0
            sender.setTitle("Start",for:.normal)
            sender.tag = 0
        }
    }
}

