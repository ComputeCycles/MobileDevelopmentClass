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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
