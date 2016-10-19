//
//  ViewController.swift
//  Lecture12
//
//  Created by Van Simmons on 10/18/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after 
        // loading the view, typically from a nib.
        scrollView.contentSize = CGSize(width: 1000.0,
                                        height: 1000.0)
        let redView = UIView(frame: CGRect(x: 50.0,
                                           y: 50.0,
                                           width: 200.0,
                                           height: 200.0))
        redView.backgroundColor = UIColor.red
        scrollView.addSubview(redView)
        
        greenView = UIView(frame: CGRect(x: 200.0,
                                           y: 200.0,
                                           width: 100.0,
                                           height: 300.0))
        greenView.backgroundColor = UIColor.green
        scrollView.addSubview(greenView)
    
        let yellowView = UIView(frame: CGRect(x: 50.0,
                                             y: 50.0,
                                             width: 50.0,
                                             height: 50.0))
        yellowView.backgroundColor = UIColor.yellow
        greenView.addSubview(yellowView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func step(_ sender: AnyObject) {
        greenView.bounds = CGRect(x: greenView.bounds.origin.x,
                                  y: greenView.bounds.origin.y - 10.0,
                                  width: greenView.bounds.size.width,
                                  height: greenView.bounds.size.height)
    }

    @IBAction func stepFrame(_ sender: AnyObject) {
        greenView.frame = CGRect(x: greenView.frame.origin.x,
                                  y: greenView.frame.origin.y - 10.0,
                                  width: greenView.frame.size.width,
                                  height: greenView.frame.size.height)
    }
}

