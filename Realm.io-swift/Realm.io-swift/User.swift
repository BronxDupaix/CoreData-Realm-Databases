//
//  User.swift 
//  
//
//  Created by Bronson Dupaix on 3/23/16.
//
//

import UIKit
import RealmSwift

class User: Object { 

    dynamic var name: String?
    
    dynamic var username: String?
    
    dynamic var password: String? 
    
    dynamic var createdAt: NSDate?
    
    dynamic var updatedAt: NSDate?

    let notes = List<Note>() 
    
    override static func primaryKey() -> String? {
        return "name"  
    }
}
