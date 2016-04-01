//
//  Timeslot.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/25/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import Foundation
import Firebase

class TimeSlot {
    
    var key: String = ""
    var name: String = ""
    var startDate = NSDate()
    var endDate = NSDate()
    var eventKey: String = "" 
    
    var timeslotRef = Firebase(url: "https://matchbox20fanclub.firebaseio.com/timeslot")
    
    init() {
    }
    
    init(key: String, dict: [String: AnyObject]) {
        
        self.key = key
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let startDateInterval = dict["startDate"] as? NSTimeInterval {
            self.startDate = NSDate(timeIntervalSince1970: startDateInterval)
        }
        if let endDateInterval = dict["endDate"] as? NSTimeInterval {
            self.endDate = NSDate(timeIntervalSince1970: endDateInterval)
        }
        if let eventKey = dict["eventKey"] as? String {
            self.eventKey = eventKey
        }
    }
    
    func saveTimeslot() {
        
        let startDateInterval = self.startDate.timeIntervalSince1970
        
        let endDateInterval = self.endDate.timeIntervalSince1970
        
        
        let dict = [
            "name": self.name,
            "startDate": startDateInterval,
            "endDate": endDateInterval,
            "eventKey": self.eventKey 
            
        ]
        
        let firebaseEvent = self.timeslotRef.childByAutoId()
        firebaseEvent.setValue(dict) 
        
    }
}