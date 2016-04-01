//
//  User.swift
//  FirebaseSampleProject-Swift
//
//  Created by Bronson Dupaix on 3/25/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import Foundation

class User {
    
    var user: String = ""
    
    init () {
        
    }
    
    func save() {
        
        let dict = [
        
            "users": {
                "mchen": {
                    "name": "Mary Chen",
                    // index Mary's groups in her profile
                    "groups": {
                        // the value here doesn't matter, just that the key exists
                        "alpha": true,
                        "charlie": true
                    }
        ]
        
        
        let firebaseQuestion = self.eventRef.childByAutoId()
        firebaseQuestion.setValue(dict)
    }

    
    }

