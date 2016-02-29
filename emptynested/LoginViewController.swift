//
//  LoginViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/15/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import Foundation
import UIKit
import Parse
import ParseFacebookUtilsV4


class LoginViewController: UIViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var email:String!
    var password:String!
    
    override func viewDidLoad() {
        
        if let nav = navigationController?.navigationBar{
            nav.backgroundColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.barTintColor = UIColor(red:191.0/255.0, green:25.0/255.0, blue:85.0/255.0, alpha:1)
            nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        //let currentUser = PFUser.currentUser()
        
        if(FBSDKAccessToken.currentAccessToken() != nil){
            //user is logged in currently
            // send them to home viewController
            print("user logged in")
            /*
            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            
            let protectedPageNav = UINavigationController(rootViewController: protectedPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = protectedPageNav
            */
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        } else {
            print("user logged out")
        }
        
   
        /*
        if(FBSDKAccessToken.currentAccessToken() != nil){
           //user is logged in currently
            // send them to home viewController
            print("user logged in")
            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! SWRevealViewController
            
            let protectedPageNav = UINavigationController(rootViewController: protectedPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = protectedPageNav

                   } else {
            print("user logged out")
        }
       */
        
    }
    
  

    @IBAction func currentUserLoginButtonTapped(sender: AnyObject) {
        if let e = emailTextField.text{
            email = e
        }
        if let p = passwordTextField.text{
            password = p
        }
        
        PFUser.logInWithUsernameInBackground(email, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Go to home page
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
   
    @IBAction func facebookLoginButtonTapped(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"], block:{(user:PFUser?, error:NSError?) -> Void in
            
            if error != nil{
                let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return  
            }
            print(user)
            print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current user id=\(FBSDKAccessToken.currentAccessToken().userID)")
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        })
    }


    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let registrationPage = self.storyboard?.instantiateViewControllerWithIdentifier("RegistrationViewController") as! RegistrationViewController
        
        let registrationPageNav = UINavigationController(rootViewController: registrationPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = registrationPageNav
    }
   
    @IBAction func forgotMyPasswordButtonTapped(sender: AnyObject) {
        
        let forgotPasswordPage = self.storyboard?.instantiateViewControllerWithIdentifier("PasswordResetViewController") as! PasswordResetViewController
        
        let forgotPasswordPageNav = UINavigationController(rootViewController: forgotPasswordPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = forgotPasswordPageNav

    }
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
}