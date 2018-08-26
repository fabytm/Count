//
//  CounterTableViewController.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit
import os.log
import WatchConnectivity


class CounterTableViewController: UITableViewController, WCSessionDelegate {
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
    
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    //MARK: Properties
    
    var counters = [Counter]()
    var session: WCSession!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //Adding edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedCounters = loadCounters(){
            counters += savedCounters
        }else{
            //Add sample data
            loadSampleCounters()
        }
        
       
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
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            counters.remove(at: indexPath.row)
            saveCounters()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    
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
            
            //Save the counters.
            saveCounters()
            
        } else if let sourceViewController = sender.source as? EditCounterViewController, let counter = sourceViewController.counterObject{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing counter
                counters[selectedIndexPath.row] = counter
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            //Save the counters.
            saveCounters()
        }
    }

    
    
    //MARK: Private Methods
    @IBAction func addOne(_ sender: UIButton) {
        
        if let indexPath = getIndexPath(of: sender){
            counters[indexPath.row].increment(by: 1)
            saveCounters()
        }
    }
    
    private func getIndexPath(of element:Any) -> IndexPath?
    {
        if let view =  element as? UIView
        {
            // Converting to table view coordinate system
            let pos = view.convert(CGPoint.zero, to: self.tableView)
            // Getting the index path according to the converted position
            return tableView.indexPathForRow(at: pos)
        }
        return nil
    }
    
    private func loadSampleCounters(){
        
        guard let counter1 = Counter(name:"Pots of coffee", count: 20) else {
            fatalError("Unable to instantiate counter 1")
        }
        
        guard let counter2 = Counter(name:"Tea kettles", count: 5) else {
            fatalError("Unable to instantiate counter 2")
        }
        
        counters += [counter1, counter2]
    }
    
    private func saveCounters(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(counters, toFile:Counter.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Counters successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save counters...",log: OSLog.default, type: .debug)
        }
    }
    
    private func loadCounters() -> [Counter]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Counter.ArchiveURL.path) as? [Counter]
    }


}
