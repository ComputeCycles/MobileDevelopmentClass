//
//  FirstViewController.swift
//  Lecture15
//
//  Created by Van Simmons on 11/7/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var colLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func changeCols(_ sender: UISlider) {
        let value = Int(sender.value)
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.engine.grid = Grid(rows: ad.engine.grid.rows, cols: value)
        colLabel.text = value.description
        let center = NotificationCenter.default
        let n = Notification(name: Notification.Name(rawValue: ENGINE_UPDATED))
        center.post(n)
    }
    
    @IBAction func changeRows(_ sender: UISlider) {
        let value = Int(sender.value)
        let ad = UIApplication.shared.delegate as! AppDelegate
        ad.engine.grid = Grid(rows: value, cols: ad.engine.grid.cols)
        rowLabel.text = value.description
        let center = NotificationCenter.default
        let n = Notification(name: Notification.Name(rawValue: ENGINE_UPDATED))
        center.post(n)
    }
    
    @IBAction func resetRefreshRate(_ sender: UITextField) {
        if let rateString = sender.text  {
            if let rate = Double(rateString) {
                let ad = UIApplication.shared.delegate as? AppDelegate
                ad?.engine.timerInterval = 1.0/rate
            }
            else {
                let alert = UIAlertController(title: "User error",
                                              message:"Please enter a number",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true) { }

                sender.text = "1.0"
            }
        }
    }
}

