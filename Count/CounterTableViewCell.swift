//
//  CounterTableViewCell.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
    var counterObject: Counter?

    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Actions
    @IBAction func addOneToCounter(_ sender: UIButton) {
        var counter: Int = Int(countLabel.text ?? "") ?? 0
        counter += 1
        countLabel.text = "\(counter)"
       /*
        let count = Int(countLabel.text ?? "") ?? 0
        let name = nameLabel.text ?? ""
        
        
        counterObject = Counter(name: name, count: count)
 */

        
    }
    

}
