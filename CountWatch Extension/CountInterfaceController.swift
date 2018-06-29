//
//  CountInterfaceController.swift
//  CountWatch Extension
//
//  Created by Fabian Butean on 07/03/2018.
//  Copyright © 2018 Fabian Butean. All rights reserved.
//

import WatchKit
import Foundation
import os.log
import WatchConnectivity

class CountInterfaceController: WKInterfaceController {

    
    
    //MARK: Properties
    @IBOutlet var dataTable: WKInterfaceTable!

   var counters = [Counter]()

    
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        

        
        // Configure interface objects here.
        
        if let savedCounters = loadCounters(){
            counters+=savedCounters
        }else{
            loadSampleCounters()
        }
        
        dataTable.setNumberOfRows(counters.count, withRowType: "CountRowController")
        
        for(index, counter) in counters.enumerated(){
            
            guard let row = dataTable.rowController(at: index) as? CountRowController else{os_log("I failed, master!", log:OSLog.default, type: .debug);break}
                row.countNameLabel.setText(counter.name)
                row.countCounterLabel.setText("\(counter.count)")
            
            
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
 //   override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
 //       guard let row = dataTable.rowController(at: ) as? CountRowController else{os_log("I failed, master!", log:OSLog.default, type: .debug)}
 //   }
    
    //MARK: Actions
    private func loadSampleCounters(){
        
        guard let counter1 = Counter(name:"Pots of coffee", count: 20) else {
            fatalError("Unable to instantiate counter 1")
        }
        
        guard let counter2 = Counter(name:"Tea kettles", count: 5) else {
            fatalError("Unable to instantiate counter 2")
        }
        
        counters += [counter1, counter2]
    }
    
    private func loadCounters() -> [Counter]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Counter.ArchiveURL.path) as? [Counter]
    }
    
    
    
    
}



