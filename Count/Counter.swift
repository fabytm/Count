//
//  Counter.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit

class Counter {
    
    //MARK: Properties
    
    var name: String
    var count: Int
    
    init?(name: String, count:Int){
        
        //Initialization should fail if there is no name or count is negative
        if name.isEmpty || count < 0{
            return nil
        }
        
        self.name = name
        self.count = count
    }


}
