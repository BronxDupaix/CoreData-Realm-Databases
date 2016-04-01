//
//  Note.swift
//  Realm.io-swift
// 
//  Created by Bronson Dupaix on 3/23/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import RealmSwift

class Note: Object {
    
        dynamic var name = ""
    
        dynamic var createdAt: NSDate?
    
        dynamic var updatedAt: NSDate?
    
        dynamic var owner: User?
    
        var owners: [User] {
            
            return linkingObjects(User.self, forProperty: "notes")
        }
    }



