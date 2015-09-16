//
//  ProfileViewController.swift
//  temp
//
//  Created by Ryan Yue on 9/9/15.
//  Copyright (c) 2015 Ryan Yue. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, GooglePlacesAutocompleteDelegate {
    
    
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyAi--AlPdyIJveiyjIAXTz2xTOmaUrYvLU",
        placeType: .Establishment
    )
    
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var testString: String!
    var testStr: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = testString
        userEmail.text = testStr
        gpaViewController.placeDelegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func followUser(sender: UIButton) {
        var newFollow: PFObject
        var query: PFQuery = PFQuery(className: "Follow")
        query.whereKey("toUser", equalTo: testString)
        if query.countObjects() == 0
        {
            newFollow = PFObject(className: "Follow")
            newFollow.setObject((PFUser.currentUser())!.username!, forKey: "fromUser")
            newFollow.setObject(testString, forKey: "toUser")
            newFollow.saveInBackgroundWithBlock { (success, error)  -> Void in
                if (error == nil)
                {
                    println("FOLLOWED")
                }
                else
                {
                    //println(error?.description)
                }
            }
        }
        else
        {
            println("already followed")
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

