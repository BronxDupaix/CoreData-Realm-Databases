//
//  ViewController.swift
//  FireIron
//
//  Created by Bronson Dupaix on 3/24/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    var dogsArray = [Dog]()
    
    let dogRef = Firebase(url: "https://fireIron.firebaseio.com/dogs")
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeDogs()
        
        seedDog()
    }
    
    
    func seedDog() {
        
        let dog = Dog()
        
        dog.name = "Loki"
        
        dog.color = "Black & White"
        
        dog.breed = "German Shephard Husky Mix"
        
        self.dateFormatter.dateFormat = "YYYY,MM,dddd HH:mm:ss"
        
        if let bday = dateFormatter.dateFromString("2014,10,31 00:00:00") {
            
            dog.birthday = bday
            
            print("This is the dogs birthday \(dog.birthday)") 
        }
    
        dog.isFertal = true
        
        dog.save()
    }
    
    
    func observeDogs() {
        
        // add observer for Dog
        
        self.dogRef.observeEventType(.Value, withBlock: {
            
            (snapShot) -> () in
            
            print(snapShot.value)
            
            self.dogsArray = []
            
            // remove all current dogs in array
            
            if let snapshots = snapShot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? [String: AnyObject] {
                        
                        
                        // This is the key firebase assigns
                        
                        let key = snap.key
                        
                        // This is the key sent to our Dog class so that it knows
                        
                        let dog = Dog(key: key, dict: dict)
                        
                        // Add dogs to our dogsArray 
                        
                        self.dogsArray.insert(dog, atIndex: 0)
                        
                        
                        print("Number of dogs:\(self.dogsArray.count)")
                        
                    }
                    
                }
                
            }
            
            
        })
    }
        
    


}

