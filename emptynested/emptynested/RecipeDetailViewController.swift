//
//  RecipeDetailViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/28/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Parse

class RecipeDetailViewController: UIViewController {

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
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock {(error: NSError?)-> Void in
            
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            
            let loginPageNav = UINavigationController(rootViewController: loginPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginPageNav
        }

    }

    @IBAction func backButtonTapped(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("RecipeRevealViewController") as! SWRevealViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
