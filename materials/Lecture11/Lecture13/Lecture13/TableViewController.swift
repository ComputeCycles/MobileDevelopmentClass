//
//  ViewController.swift
//  Lecture13
//
//  Created by Van Simmons on 10/17/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var names = [
        "Ben",
        "Monica",
        "Van",
        "Eric",
        "Jack",
        "Mark",
        "Matt"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: DataSource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count/2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = indexPath.row % 2 == 0 ? "nameCell" : "alternateNameCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName)
            else {
                preconditionFailure("Could not get a nameCell.  You probably did not set it correctly in the Storyboard")
        }
        cell.textLabel!.text = names[indexPath.section * names.count / 2 + indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Title for section: \(section)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tappedCell = sender as? UITableViewCell
            else {
                preconditionFailure("no tableViewCell")
        }
        guard let editorViewController = segue.destination as? NameEditorViewController
            else {
                preconditionFailure("bad segue")
        }
        
        editorViewController.saveClosure = {
            tappedCell.textLabel?.text = $0
        }
    }
}
