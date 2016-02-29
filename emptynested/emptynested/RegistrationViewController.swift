//
//  RegistrationViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/17/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class RegistrationViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    var username:String!
    var password:String!
    var email:String!
    var confirmPassword:String!
    let user = PFUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let nav = navigationController?.navigationBar{
            nav.backgroundColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.barTintColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        // Do any additional setup after loading the view.
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

    @IBAction func submitButtonTapped(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        /*
        if let un = nameTextField.text{
            username = un
        }
        if let e = emailTextField.text{
            email = e
        }
        if let p = newPasswordTextField.text{
            password = p
        }
        if let cp = confirmPasswordTextField.text{
            confirmPassword = cp
        }
        //regex for valid email and password
        if email != nil || username != nil || password != nil || confirmPassword != nil{
            user.email = email
            user.username = username
            if password == confirmPassword{
                user.password = password
                addingUser()
            } else {
               //alert password does not match
                return
            }
        } else {
            //alert that a field is empty
        }
        */
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPageNav

    }
    
    
    func addingUser() {
        
        //user.username = username
        //user.password = password
        //user.email = email
        
        
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print(errorString)
                // Show the errorString somewhere and let the user try again.
            } else {
                // take user to home page
            }
        }
    }
    
}
