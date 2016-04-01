//
//  TimeslotsViewController.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/25/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import Firebase

class TimeslotsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var currentEventKey = ""
    
    var timeslotsArray = [TimeSlot]()
    
    var timeslotRef = Firebase(url: "https://matchbox20fanclub.firebaseio.com/timeslot")

    @IBOutlet weak var timeSlotTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observeTimeslots()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        print(self.currentEventKey) 
    }
    
    @IBAction func signUpForTimeButton(sender: UIButton) {
        
        
        let alertController = UIAlertController(title: "Add", message: "Please add an Event", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (alertAction) -> Void in
            
            print("SavePressed")
            
            if let textField = alertController.textFields?.first,
                let name = textField.text {
                    
                    
                    
                    self.saveTimeslot(name)
                    
                    self.timeSlotTableview.reloadData()
                    
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (alertAction) -> Void in
            
            print("CancelledPressed")
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        
        alertController.addAction(cancelAction)
        
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)

        
        self.timeSlotTableview.reloadData()
        
        print("button pressed")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let time = timeslotsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell")
        
        cell!.textLabel?.text = time.name
        
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.timeslotsArray.count
    }
    
    func saveTimeslot(name: String) {
        
        let time = TimeSlot()
        
        time.name = name
        
        time.saveTimeslot()
    }

    
    func observeTimeslots() { 
        
        
        self.timeslotRef.observeEventType(.Value, withBlock: {
            
            (snapShot) -> () in
            
            print(snapShot.value)
            
            self.timeslotsArray = []
            
            if let snapshots = snapShot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? [String: AnyObject] {
                        
                        
                        let key = snap.key
                        
                        let event = TimeSlot(key: key, dict: dict)
                        
                        
                        self.timeslotsArray.insert(event, atIndex: 0)
                        
                        
                        print("Number of timeslots:\(self.timeslotsArray.count)")
                        
                        self.timeSlotTableview.reloadData()
                    }
                    
                }
                
            }
            
            print("Timeslots observed") 
            
        })
        
        
    }

    
    
}
