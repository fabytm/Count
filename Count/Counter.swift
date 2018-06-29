//
//  Counter.swift
//  Count
//
//  Created by Fabian Butean on 21/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import UIKit
import os.log


class Counter: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var count: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("counters")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let count = "count"
    }
    
    init?(name: String, count:Int){
        
        //Initialization should fail if there is no name or count is negative
        if name.isEmpty || count < 0{
            return nil
        }
        
        self.name = name
        self.count = count
    }

    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(count, forKey: PropertyKey.count)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The name of the counter is required. If we cannot decode a name string, the initializer should fail.
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a Count object.", log: OSLog.default, type: .debug)
            return nil
        }
        let count = aDecoder.decodeInteger(forKey: PropertyKey.count)
        
        self.init(name: name, count: count)
    }
}
