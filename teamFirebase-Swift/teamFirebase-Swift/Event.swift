//
//  Event.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/24/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    var eventkey: String = ""
    
    var name: String = ""
    
    var genre: String = ""
    
    var startDate = NSDate()
    
    var endDate = NSDate()
    
    
    var eventRef = Firebase(url: "https://matchbox20fanclub.firebaseio.com/events")
    
    init () {
        
    }
    
    
    init(key: String, dict: [String: AnyObject]) {
        
        self.eventkey = key 
        
        if let name = dict["name"] as? String {
            
            self.name = name
        } else {
            
            print("couldnt parse name")
        }
        
        if let genre = dict["genre"] as? String {
            
            
            self.genre = genre
        } else {
            
            print("Couldnt print genre")
        }
        
        if let startDate = dict["startDate"] as? NSTimeInterval {
            
            self.startDate = NSDate(timeIntervalSince1970: startDate)
        } else {
            
            print("coudlnt parse startDate")
        }
        
        if let endDate = dict["endDate"] as? NSTimeInterval {
            
            self.endDate = NSDate(timeIntervalSince1970: endDate)
        } else {
            
            print(" cant parse endDate")
        }
        
        
        self.eventRef = self.eventRef.childByAppendingPath(self.eventkey) 
    } 
    
    func save() {
        
        let startDateInt = self.startDate.timeIntervalSince1970
        
        let endDateInt = self.endDate.timeIntervalSince1970
        
        let dict = [
            "name": self.name,
            "genre": self.genre,
            "startDate": startDateInt,
            "endDate": endDateInt
        ]
        
        
        let firebaseQuestion = self.eventRef.childByAutoId()
        firebaseQuestion.setValue(dict)
    }


}