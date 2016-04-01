//
//  NotesTableViewController.swift
//  Realm.io-swift
//
//  Created by Bronson Dupaix on 3/23/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import RealmSwift


class NotesTableViewController: UITableViewController{
    
    var user: User?
    
    let realm = try! Realm()
    
    let dateFormatter = NSDateFormatter()
    
    var notesArray = [Note]()
    
    var noteName = ""
    
    var noteDate = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Notes view loaded")
        
        print(user?.name)
        
        print(user?.password)
        
        queryRealm()
        
        
        
    }
    
    @IBAction func addNoteButton(sender: UIBarButtonItem) {
        
        print("AddTaskTapped")
        //Step-1 create a UIAlertController
        let alertController = UIAlertController(title: "Add", message: "Please add a Note", preferredStyle: .Alert)
        
        //Step-2 create action for alert controller/ Save and Cancel
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (alertAction) -> Void in
            
            print("SavePressed")
            
            // Step-5 add textfield
            
            if let textField = alertController.textFields?.first,
                let name = textField.text {
                    
                    let createdDate = NSDate()
                    
                  //  self.dateFormatter.dateFormat = "MM-dd-yy HH:mm:ss"
                    
                    let created = self.dateFormatter.stringFromDate(createdDate)
                    
                    self.seedRealm(name, createdDate: createdDate)
                    
                    print(created)
                
                    self.queryRealm()
                    
            }

            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (alertAction) -> Void in
            
            print("CancelledPressed")
        }
        
        //Step-6 add text field to alert controller
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        
        //Step-3 add actions to alert controller
        alertController.addAction(saveAction)
        
        alertController.addAction(cancelAction)
        
        //Step-4 present the action view controller over the top of the current view controller
        
        self.presentViewController(alertController, animated: true, completion:nil)

        
    }
    



    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return notesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let notes = notesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell
        
        
        cell.noteNameLabel.text = notes.name
            
           // print(noteName)
        
        cell.createdDateLabel.text = "Today"
            
           // print(noteDate)
        
        cell.ownerNameLabel.text = self.user!.name
            
        // cell.backgroundColor = UIColor.blueColor()
        
        return cell
            
            
    }


    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }
    
    func queryRealm()  {
        
        // let notes = realm.objects(User).filter("name = '\(user!.name)'")
        
        let notes = self.user?.notes
        
        self.notesArray.removeAll()
        
        for note in notes! {
            
            print("This is the \(user?.name) notes name \(note.name)")
            
            self.notesArray.append(note)
            
            self.tableView.reloadData()
        }
        
    }
    
    func seedRealm(name: String, createdDate: NSDate) {
        
        var myNote = Note()
        
        let user = self.user
        
        myNote.owner = self.user
        
        myNote.name = name
        
        myNote.createdAt = createdDate
        
        try! realm.write {
            
            user?.notes.append(myNote)
            
            print("note added")
            realm.add(user!)
            
           
           print(user!.notes.count)
            
        }
        
    }


}
