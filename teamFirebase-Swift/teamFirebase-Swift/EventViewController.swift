//
//  EventViewController.swift
//  teamFirebase-Swift
//
//  Created by Bronson Dupaix on 3/25/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var eventsArray = [Event]()
    
    var currentEvent: Event?
    
    var eventKey = ""
    
    let dateFormatter = NSDateFormatter()
    
    let eventRef = Firebase(url: "https://fireIron.firebaseio.com/events") 

    @IBOutlet weak var eventsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeEvents()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }

    @IBAction func addEventButton(sender: UIButton) {
            print("AddTaskTapped")
        
            let alertController = UIAlertController(title: "Add", message: "Please add an Event", preferredStyle: .Alert) 

            let saveAction = UIAlertAction(title: "Save", style: .Default) { (alertAction) -> Void in
                
                print("SavePressed")

                if let textField = alertController.textFields?.first,
                    let name = textField.text {
                        
                        let startDate = "10,31,2016 12:00"
                        
                        let endDate = "10,31,2016 12:00"
                        
                        let genre = "Metal"
                        
                        self.seedEvent(name, startDate: startDate, endDate: endDate, genre: genre)
                        
                        self.eventsTableView.reloadData()
                        
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
        }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let event = eventsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as? EventTableViewCell
        
        cell!.eventNameLabel.text  = event.name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let event = eventsArray[indexPath.row]
        
        self.currentEvent = event
        
        self.eventKey = event.eventkey
        
        performSegueWithIdentifier("EventSegue", sender: self.currentEvent)
    }
    
    
    func seedEvent(name: String, startDate: String, endDate: String, genre: String) {
        
        let event = Event()
        
        let time = TimeSlot()
        
        time.eventKey = event.eventkey 
        
        event.name = name
        
        event.genre = genre 
        
        self.dateFormatter.dateFormat = "YYYY,MM,dddd HH:mm"
        
        if let eventStartDate =  dateFormatter.dateFromString("\(startDate)") {
            
            event.startDate = eventStartDate
            
        }
        
        if let eventEndDate = dateFormatter.dateFromString("\(endDate)") {
            
            event.endDate = eventEndDate
            
        }
        
        time.saveTimeslot() 
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
                        
//                        let time = TimeSlot()
                        
//                        time.eventKey = event.eventkey
                        
//                        time.saveTimeslot()
                        
                        self.eventsArray.insert(event, atIndex: 0)
                        
                        
                        print("Number of events:\(self.eventsArray.count)")
                        
                        self.eventsTableView.reloadData()
                    }
                    
                }
                
            }
            
            print("Events observed")
            
        })
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EventSegue" {
            
            if let destinationController = segue.destinationViewController as? TimeslotsViewController {
                
                destinationController.currentEventKey = self.eventKey 
            }
            
        }
    }
    
}
