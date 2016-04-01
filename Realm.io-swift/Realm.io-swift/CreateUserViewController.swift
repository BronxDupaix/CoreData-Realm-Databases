//
//  CreateUserViewController.swift
//  Realm.io-swift
//
//  Created by Bronson Dupaix on 3/23/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import RealmSwift 

class CreateUserViewController: UIViewController,UITextFieldDelegate {

    let realm = try! Realm()
    
    @IBOutlet weak var createUsernameTextfield: UITextField!
    
    @IBOutlet weak var createPasswordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func createUserButton(sender: UIButton) {
        
        print("Create user button pressed")
        
        let userID = createUsernameTextfield.text
        
        let password = createPasswordTextfield.text
        
        let createdDate = NSDate()
        
        seedRealm(userID!, password: password!, date: createdDate, userName: userID!)
        
    }
    
    func seedRealm(userID:String, password:String, date:NSDate, userName: String) {
        
        // Use them like regular Swift objects
        
        var userID = User()
        
        print(userID)
        
        userID.name = userName 
        
        userID.username = userName
        
        userID.password = password
        
        userID.createdAt = date
        
        // Persist your data easily
        try! realm.write {
            realm.add(userID) 
            
            print("User added")
        }
        
        
    }
    
    
}

