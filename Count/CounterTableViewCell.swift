//
//  CounterTableViewCell.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
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

}
