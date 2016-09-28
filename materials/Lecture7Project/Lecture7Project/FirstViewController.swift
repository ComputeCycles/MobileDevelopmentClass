//
//  FirstViewController.swift
//  Lecture7Project
//
//  Created by Van Simmons on 9/27/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performCalculation(_ sender: AnyObject) {
        print("Hey the button got pushed")
        textField.text = Date().description
    }

}

