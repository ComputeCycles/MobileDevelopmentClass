//
//  ViewController.swift
//  Lecture13A
//
//  Created by Van Simmons on 10/24/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fetch(_ sender: AnyObject) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=boston,%20ma&appid=77e555f36584bc0c3d55e1e584960580") else {
            return
        }
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: url) { (json, message) in
            print("\(json), \(message)")
        }
        print("Hey I'm here")
    }
    
    
    
    
    

}

