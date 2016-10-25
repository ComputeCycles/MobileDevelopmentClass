//
//  NameEditorViewController.swift
//  Lecture11
//
//  Created by Van Simmons on 10/17/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class NameEditorViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    var saveClosure: ((String) -> Void )?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(_ sender: AnyObject) {
        saveClosure?(nameTextField!.text!)
    }

}
