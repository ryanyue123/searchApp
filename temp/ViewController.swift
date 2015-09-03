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
class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var userSearch: UISearchBar!
    var searchActive: Bool?
    var users: [AnyObject]?
    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        queryParseForListWithCallback(userList)
//        
//    }
//    
//    func queryParseForListWithCallback(completion: ([AnyObject]) -> ())
//    {
//        var query: PFQuery = PFQuery(className: "_User")
//        query.fromLocalDatastore()
//        query.whereKey("username", equalTo: userSearch.text)
//        println(userSearch.text)
//        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
//            if ((error) == nil)
//            {
//                completion(objects!)
//            }
//            else
//            {
//                println(error?.userInfo)
//            }
//        }
//    }
//    
//
//    func userList(userlist: [AnyObject])
//    {
//        users = userlist
//    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var query: PFQuery = PFQuery(className: "_User")
        query.fromLocalDatastore()
        query.whereKey("username", equalTo: userSearch.text)
        println(userSearch.text)
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            if ((error) == nil)
            {
                println(objects)
            }
            else
            {
                println(error?.userInfo)
            }
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
    
}

