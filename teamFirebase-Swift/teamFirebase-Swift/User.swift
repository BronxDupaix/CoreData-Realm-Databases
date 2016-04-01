//
//  User.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/25/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import Foundation
import Firebase
class User {
    
    var key: String = ""
    var email: String = ""
    var password: String = ""
    var created = NSDate()
    
    var userRef = Firebase(url: "https://matchbox20fanclub.firebaseio.com/users")
    
    init(){}
    
    init(key: String, dict: [String: AnyObject]) {
        
        self.key = key
        
        if let email = dict["email"] as? String {
            self.email = email
        }
        
        if let password = dict["password"] as? String {
            self.password = password
        }
        if let startDateInterval = dict["created"] as? NSTimeInterval {
            self.created = NSDate(timeIntervalSince1970: startDateInterval)
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM/dd/yyyy"
        
    }
    
    func save() {
        // Create dict out of object
        
        let createdDateInterval = self.created.timeIntervalSince1970
        
        let dict = [
            "email": self.email,
            "created": createdDateInterval,
            "password": self.password
        ]
        
        // Create firebase object
        let firebaseEvent = self.userRef.childByAutoId()
        firebaseEvent.setValue(dict)
    }
}