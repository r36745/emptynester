//
//  ProfileViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/20/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var kidsEditText: UITextField!
    @IBOutlet var activityEditText: UITextField!
    @IBOutlet var updateButton: LivelyDesignedButton!
    
    var isActive:Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kidsEditText.hidden = true
        activityEditText.hidden = true
        updateButton.hidden = true
       
        if let nav = navigationController?.navigationBar{
            nav.backgroundColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.barTintColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


       //query parse user details if available place to labels
        
        let query = PFQuery(className:"GameScore")
        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                
                if self.revealViewController() != nil {
                    self.menuButton.target = self.revealViewController()
                    self.menuButton.action = "revealToggle:"
                    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                }

                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }       
        fbProfile()
        // Do any additional setup after loading the view.
    }
    
    func fbProfile(){
        let requestParameters = ["fields":"first_name, last_name, id, email, picture.type(large)"]
        
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if error != nil{
                print("\(error.localizedDescription)")
            }
            
            
            if(result != nil){
                let userId:String! = result["id"] as! String
                let userFirstName:String! = result["first_name"] as! String
                let userLastName:String! = result["last_name"] as! String
                let userEmail:String! = result["email"] as! String
                
                self.firstName.text = userFirstName
                self.lastName.text = userLastName
                self.email.text = userEmail
                
                
                print("\(userEmail)")
                let myUser:PFUser = PFUser.currentUser()!
                
                if let fn = userFirstName{
                    myUser.setObject(fn, forKey: "first_name")
                    
                }
                if let ln = userLastName{
                    myUser.setObject(ln, forKey: "last_name")
                    
                }
                if let ue = userEmail{
                    myUser.setObject(ue, forKey: "email")
                    
                }
                if let id = userId{
                    myUser.setObject(id, forKey: "id")
                    
                }
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    let profilePictureUrl = NSURL(string: userProfile)
                    let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                    //self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
                    self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.imageView.image = UIImage(data: NSData(contentsOfURL: profilePictureUrl!)!)
                    if(profilePictureData != nil){
                        let profileFileObject = PFFile(data: profilePictureData!)
                        myUser.setObject(profileFileObject!, forKey: "profile_picture")
                    }
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if(success){
                            print("You're updated")
                        }
                        
                    })
                

                })
                /*
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                    let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    let profilePictureUrl = NSURL(string: userProfile)
                    let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                    //self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
                    self.imageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
                    self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.imageView.image = UIImage(data: NSData(contentsOfURL: profilePictureUrl!)!)
                    if(profilePictureData != nil){
                        let profileFileObject = PFFile(data: profilePictureData!)
                        myUser.setObject(profileFileObject!, forKey: "profile_picture")
                    }
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if(success){
                            print("You're updated")
                        }
                        
                    })
                }
                */
            }
        }

    }

    @IBAction func editButtonTapped(sender: AnyObject) {
        
      
        
        if(isActive == false){
            kidsEditText.hidden = true
            activityEditText.hidden = true
            updateButton.hidden = true
            isActive = true
        } else {
            kidsEditText.hidden = false
            activityEditText.hidden = false
            updateButton.hidden = false
            isActive = false
        }
        
    }
    
    @IBAction func updateButtonTapped(sender: AnyObject) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
