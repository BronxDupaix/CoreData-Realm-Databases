//
//  LoginViewController.swift
//  Realm.io-swift
//
//  Created by Bronson Dupaix on 3/23/16.
//  Copyright © 2016 Bronson Dupaix. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    let realm = try! Realm()
    
    var usersArray = [User]()
    
    var currentUser: User?
    

    @IBOutlet weak var enterUsernameTextfield: UITextField!
    
    @IBOutlet weak var enterPasswordTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryRealm()

    }
    
    @IBAction func loginButton(sender: UIButton) {
        
        let currentUsername = enterUsernameTextfield.text
        
        var currentPassword = enterPasswordTextfield.text
        
        for user in usersArray {
            
            self.currentUser = user 
        
        
        if currentUsername == user.username  {
            
            print("username is correct \(currentUser?.username)")
            
            if currentPassword == user.password {
                
                performSegueWithIdentifier("LoginSegue", sender: self)
                
                self.currentUser = user 
                
                print("password  is correct")
                
            } else {
                
                print("password is incorrect")
            }
            
        } else {
            
            print("username is incorrect")
        }
        
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            if segue.identifier == "LoginSegue"{
                
                
                    let viewcontroller = segue.destinationViewController as! NotesTableViewController
                    
                    viewcontroller.user = self.currentUser
                    
                    print( "This is the user being passed\(viewcontroller.user)") 
                
                   // print(segue.identifier)


                
            }
    }
    
    func queryRealm()  {
        
        let users = realm.objects(User)
        
        print("this is the number of current users\(users.count)")
        
        self.usersArray.removeAll()
        
        for user in users {
            
            print("Username:\(user.username)")
            
            print("Password:\(user.password)")
            
            self.usersArray.append(user)
        }
        
    }


}
