//
//  PasswordResetViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/17/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class PasswordResetViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
   
    var email:String!

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
    
    
    @IBAction func resetMyPasswordButtonTapped(sender: AnyObject) {
        if let e = emailTextField.text{
            email = e
            if email != ""{
                let alert = UIAlertController(title: "Password Reset", message: "Check your email", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
                PFUser.requestPasswordResetForEmailInBackground(email)
                
                emailTextField.text = ""
                let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                
                let loginPageNav = UINavigationController(rootViewController: loginPage)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = loginPageNav

            } else{
                //set alert that email field is empty
                let alert = UIAlertController(title: "Invalid Email", message: "Enter a valid email address", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
                
                emailTextField.text = ""
                
            }
        }
        
    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = loginPageNav
    }
}
