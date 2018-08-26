//
//  EditCounterViewController.swift
//  Count
//
//  Created by Fabian Butean on 22/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit
import os.log


class EditCounterViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var counterNumberLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var counterNameLabel: UINavigationItem!
    @IBOutlet var alterButtons: [UIButton]!
    
    
    /*
     This value is either passed by 'CounterTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new meal.
     */
    var counterObject: Counter?



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        if let counterObject = counterObject {
            navigationItem.title = counterObject.name
            counterNumberLabel.text = "\(counterObject.count)"

        }
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(self.isMovingFromParentViewController){
            let count = Int(counterNumberLabel.text ?? "") ?? 0
            let name = counterNameLabel.title ?? ""
            
            counterObject = Counter(name: name, count: count)
            
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //updateSaveButtonState()
        navigationItem.title = textField.text
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing.
        //saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    //@IBAction func cancel(_ sender: UIBarButtonItem) {
   //     dismiss(animated: true, completion: nil)
   // }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log:OSLog.default, type: .debug)
            return
        }
        let count = Int(counterNumberLabel.text ?? "") ?? 0
        let name = counterNameLabel.title ?? ""

        
        counterObject = Counter(name: name, count: count)
        
    }
    
    
   //MARK: Actions

    @IBAction func alterNumberLabel(_ sender: UIButton){
        if let buttonFunction = alterButtons.index(of: sender){
            switch buttonFunction {
            case 0:
                counterObject?.decrement(by: 1)
            case 1:
                counterObject?.increment(by: 1)
            case 2:
                counterObject?.decrement(by: 10)
            case 3:
                counterObject?.increment(by: 10)
            default:
                break
            }
           counterNumberLabel.text = "\(counterObject?.count ?? 0)"
        }
    }
    
    
    //MARK: Private Methods
    
    /*private func updateSaveButtonState(){
        //Disable the save button if the text field is empty.
        let text = nameTextField.text ?? ""
        //saveButton.isEnabled = !text.isEmpty
    }
    */

}
