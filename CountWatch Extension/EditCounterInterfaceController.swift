//
//  EditCounterInterfaceController.swift
//  CountWatch Extension
//
//  Created by Fabian Butean on 28/06/2018.
//  Copyright © 2018 Fabian Butean. All rights reserved.
//

import WatchKit
import Foundation


class EditCounterInterfaceController: WKInterfaceController {
    
    
    //MARK: Properties
    @IBOutlet var counterNameLabel: WKInterfaceLabel!
    @IBOutlet var counterNumberLabel: WKInterfaceLabel!
    @IBOutlet var alterButtons: [WKInterfaceButton]!
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: Actions
    /*
    @IBAction func alterNumberLabel(_ sender: WKInterfaceButton) {
        if let buttonFunction = alterButtons.index(of: sender){
            //var counter: Int = Int( ?? "") ?? 0
            switch buttonFunction{
            case 0:
                counter = counter + 1
                
            case 1:
                if(counter >= 1){
                    counter = counter - 1
                }
            case 2:
                counter = counter + 10
            default:
                break
            }
            counterNumberLabel.setText("\(counter)")
            
        }
    }
    */

}
