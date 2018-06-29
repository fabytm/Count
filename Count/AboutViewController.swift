//
//  AboutViewController.swift
//  Count
//
//  Created by Fabian Butean on 18/11/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var versionNumberLabel: UILabel!
    
    
    let versionNumberString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        versionNumberLabel.text = "Version " + versionNumberString

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func youtubeButton(_ sender: UIButton) {
        if let youtubeURL = NSURL(string:"http://www.YouTube.com/TheFabytm"){
            UIApplication.shared.open(youtubeURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
