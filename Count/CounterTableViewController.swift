//
//  CounterTableViewController.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit
import os.log

class CounterTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var counters = [Counter]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Add sample data
        loadSampleCounters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return counters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CounterTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CounterTableViewCell else{
            fatalError("The dequeued cell is not an instance of CounterTableViewCell")
        }
        
        let counter = counters[indexPath.row]
        
        cell.nameLabel.text = counter.name
        cell.countLabel.text = "\(counter.count)"
        

        // Configure the cell...

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
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
        
            case "AddItem":
                os_log("Adding a new meal.", log:OSLog.default, type: .debug)
        
            case "EditItem":
            guard let counterEditViewController = segue.destination as? EditCounterViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
        }
            
            guard let selectedCounterCell = sender as? CounterTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCounterCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCounter = counters[indexPath.row]
            counterEditViewController.counterObject = selectedCounter
            //counterEditViewController.row = indexPath.row
            
        default:
            fatalError("Unexpected Segue Identifier : \(String(describing: segue.identifier))")
            
        }
        
        
    }
    
    
    //MARK: Actions
    @IBAction func unwindToCounterList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddCounterViewController, let counter = sourceViewController.counterObject{
            //Add a new counter.
            let newIndexPath = IndexPath(row: counters.count, section: 0)
            counters.append(counter)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        }
        
        
    }
    
    //MARK: Private Methods
    
    private func loadSampleCounters(){
        
        guard let counter1 = Counter(name:"Pots of coffee", count: 20) else {
            fatalError("Unable to instantiate counter 1")
        }
        
        guard let counter2 = Counter(name:"Tea kettles", count: 5) else {
            fatalError("Unable to instantiate counter 2")
        }
        
        counters += [counter1, counter2]
    }

}
