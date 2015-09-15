//
//  AddEventViewController.swift
//  temp
//
//  Created by Ryan Yue on 9/12/15.
//  Copyright (c) 2015 Ryan Yue. All rights reserved.
//

import UIKit
import Parse
class AddEventViewController: UIViewController, GooglePlacesAutocompleteDelegate {

    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var locationName: UILabel!
    
    @IBAction func addLoc(sender: UIButton) {
        presentViewController(gpaViewController, animated: true, completion: nil)
    }
    
    @IBAction func submitEvent(sender: UIButton) {
    }
    
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyAi--AlPdyIJveiyjIAXTz2xTOmaUrYvLU",
        placeType: .Establishment
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gpaViewController.placeDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeSelected(place: Place) {
        locationName.text = place.description
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveEvent(sender: UIButton) {
        var newEvent: PFObject
        newEvent = PFObject(className: PFUser.currentUser()!.username! + "_Content" )
        newEvent.setObject(eventTitle.text, forKey: "Event_Title")
        newEvent.setObject(locationName.text!, forKey: "Location")
        newEvent.setObject(PFUser.currentUser()!.username!, forKey: "User")
        newEvent.saveInBackgroundWithBlock { (success, error)  -> Void in
            if (error == nil)
            {
                println("EVENT ADDED")
            }
            else
            {
                //println(error?.description)
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
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
