//
//  ProtectedPageViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/16/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class ProtectedPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                let profilePictureUrl = NSURL(string: userProfile)
                let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                
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
                
            }
        }
        
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
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock {(error: NSError?)-> Void in
            
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! PFViewController
            
            let loginPageNav = UINavigationController(rootViewController: loginPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginPageNav
        }
        
        
    }

}
