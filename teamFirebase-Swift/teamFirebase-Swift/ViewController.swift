//
//  ViewController.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/24/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let eventRef = Firebase(url: "https://matchbox20fanclub.firebaseio.com/events")
    
    var eventsArray = [Event]()
    
    let dateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  observeEvents()
        
       // seedEvent()
       
    }
    
    func seedEvent() {
        
        let event = Event()
        
        event.name = "Loki"
        
        event.genre = "Metal"
        
        self.dateFormatter.dateFormat = "YYYY,MM,dddd HH:mm:ss"
        
        if let startDate = dateFormatter.dateFromString("2014,10,31 00:00:00") {
            
            event.startDate = startDate
            
        }

        if let endDate = dateFormatter.dateFromString("2015,10,31 00:00:00") {
            
            event.endDate = endDate
            
        }
        
        
        event.save()
    }
    
    
    func observeEvents() {
        
        
        self.eventRef.observeEventType(.Value, withBlock: {
            
            (snapShot) -> () in
            
            print(snapShot.value)
            
            self.eventsArray = []
            
            
            if let snapshots = snapShot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? [String: AnyObject] {
                        
                        
                        let key = snap.key
                        
                        let event = Event(key: key, dict: dict)
                   
                        
                        self.eventsArray.insert(event, atIndex: 0)
                        
                        
                        print("Number of events:\(self.eventsArray.count)") 
                        
                    }
                    
                }
                
            }
            
            
        })
    }

}

