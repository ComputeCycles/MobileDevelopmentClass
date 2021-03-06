//
//  ConfigurationViewController.swift
//  Lecture15
//
//  Created by Van Simmons on 11/22/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {

    var json: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json") else {
            return
        }
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: url) { (_ result: EitherOr) in
            switch result {
            case .success(let json):
                self.json = json as? [Any] ?? []
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
                
            case .failure:
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return json.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Configuration",
                                                 for: indexPath)

        // Configure the cell...
        let row = json[indexPath.row] as! [String: Any]
        cell.textLabel?.text = row["title"] as? String
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let destination = segue.destination as? ConfigGridViewController
            else {
                return
            }
        let row = self.tableView.indexPathForSelectedRow!.row
        if let config = json[row] as? [String: Any] {
            destination.config = config
        }
    }
}
