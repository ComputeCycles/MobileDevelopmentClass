//
//  ViewController.swift
//  Lecture11
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = indexPath.row % 2 == 0 ? "nameCell" : "alternateNameCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName)
            else {
                preconditionFailure("Could not get a nameCell.  You probably did not set it correctly in the Storyboard")
            }
        cell.textLabel!.text = names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Title for section: \(section)"
    }
    
    //MARK: Delegate Methods
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
            //            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.yellow
//    }
    
    //MARK: Editor ViewController Support
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

