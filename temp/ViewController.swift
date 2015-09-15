//
//  ViewController.swift
//  temp
//
//  Created by Ryan Yue on 9/2/15.
//  Copyright (c) 2015 Ryan Yue. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import GoogleMaps

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var userSearch: UISearchBar!
    var profileuser: PFUser!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var query = PFUser.query()!
        query.whereKey("username", equalTo: searchBar.text)
        if let user = query.getFirstObject() as? PFUser
        {
            profileuser = user
            self.performSegueWithIdentifier("showProfile", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userSearch.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (PFUser.currentUser() == nil)
        {
            var logInViewController = PFLogInViewController()
            logInViewController.delegate = self
            
            var signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            
            logInViewController.signUpController = signUpViewController
            
            self.presentViewController(logInViewController, animated: true, completion: nil)
        }
        searchForEvents()
    }
    
    
    
    
    @IBAction func signOut(sender: UIBarButtonItem) {
        
        PFUser.logOut()
        var logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        
        var signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        
        logInViewController.signUpController = signUpViewController
        self.presentViewController(logInViewController, animated: true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("failed to login")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        if let password = info["password"] as? String{
            return count(password.utf16) >= 8
        }
        else
        {
            return false
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("failed to signup")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("user canceled signup")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showProfile")
        {
            let upcoming = segue.destinationViewController as! ProfileViewController
            
            upcoming.testString = profileuser.username
            upcoming.testStr = profileuser.email
        }
    }
    
    func searchForEvents()
    {
//        var followArray: NSMutableArray = []
//        var q = PFQuery(className: PFUser.currentUser()!.username!)
//        q.selectKeys(["toUser"])
//        q.findObjects()
//        
//        
//        println("\n\n")
//        println(q.getFirstObject()?.description)
//        println("\n\n")
//        
//        
//        
//        var query = PFQuery(className: PFUser.currentUser()!.username! + "_Content")
//        query.orderByDescending("updatedAt")
//        query.findObjects()
//
//        
//        var temp = query.getFirstObject()!["Location"] as? String
//
//        
////        if query.countObjects() != 0
////        {
////            var obj = query.getFirstObject()!
////            eventName.text = obj["Event_Title"] as? String
////            locationName.text = obj["Location"] as? String
////            addedBy.text = obj["User"] as? String
////        }
    }

    
    
    
    
}

