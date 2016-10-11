//
//  ViewController.swift
//  Lecture9
//
//  Created by Van Simmons on 10/10/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    var grid = Grid(rows: 10, cols: 10)
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gridView.grid = grid
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func step(sender:AnyObject) {
        grid = grid.step()
        gridView.grid = grid
        gridView.setNeedsDisplay()
    }
    
    @IBAction func start(sender:UIButton) {
        if sender.tag == 0 {
            grid.timerInterval = 1.0
            sender.setTitle("Stop",for:.normal)
            sender.tag = 1
        }
        else {
            grid.timerInterval = 0.0
            sender.setTitle("Start",for:.normal)
            sender.tag = 0
        }
    }
}

