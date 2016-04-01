//
//  Dog.swift
//  FireIron
//
//  Created by Bronson Dupaix on 3/24/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import Foundation
import Firebase

class Dog {
    
    var key: String = ""
    
    var name: String = ""
    
    var color: String = ""
    
    var breed: String = ""
    
    var birthday = NSDate()
    
    var isFertal = false
    
    var dogRef = Firebase(url: "https://fireIron.firebaseio.com/dogs")
    
    init () {
        
    }
    
    
    init(key: String, dict: [String: AnyObject]) {
        
        if let name = dict["name"] as? String {
            
            self.name = name
        } else {
            
            print("couldnt parse name")
        }
        
        if let color = dict["color"] as? String {
            
            self.color = color
        } else {
            
            
            print("couldnt parse color")
        }
        
        if let breed = dict["breed"] as? String {
            
            self.breed = breed
        } else {
            
            print("couldnt parse breed")
        }
        
        if let birthday = dict["birthday"] as? NSTimeInterval {
            
            self.birthday = NSDate(timeIntervalSince1970: birthday)
            
        } else {
            
            print("couldnt parse birthday")
        }
        
        
        if let isFertal = dict["isFertal"] as? Bool {
            
            
            self.isFertal = isFertal
        } else {
            
            print(" couldnt parse Fertal")
        }
    }
    
    func save() {
        
        let bDayInterval = self.birthday.timeIntervalSince1970
        
        let dict = [
            "name": self.name,
            "color": self.color,
            "breed": self.breed,
            "birthday": bDayInterval,
            "isFertal": self.isFertal

        ]
        
        
        let firebaseQuestion = self.dogRef.childByAutoId()
        firebaseQuestion.setValue(dict)
    }

    
    
}