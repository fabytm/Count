//
//  CounterViewController.swift
//  Count
//
//  Created by Fabian Butean on 19/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit
import os.log


class CounterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var counterNumberLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
 This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new meal.
 */
    var counterObject: Counter?
    
    var counter = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        //Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationBarTitle.title = textField.text
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log:OSLog.default, type: .debug)
            return
        }
    
        let name = nameTextField.text ?? ""
        let count = Int(counterNumberLabel.text ?? "") ?? 0
        
        counterObject = Counter(name: name, count: count)

    }
    
    
    //MARK: Actions
    @IBAction func addOneToCounter(_ sender: UIButton) {
        counter += 1
        counterNumberLabel.text = "\(counter)"
    }
    
    @IBAction func addTenToCounter(_ sender: UIButton) {
        counter += 10
        counterNumberLabel.text = "\(counter)"
    }
    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        //Disable the save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

