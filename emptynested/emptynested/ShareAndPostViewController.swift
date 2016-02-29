//
//  ShareAndPostViewController.swift
//  emptynested
//
//  Created by Steven Roseman on 2/18/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import UIKit
import Foundation
import Parse
import Social

class ShareAndPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var shareFBButton: FBSDKShareButton!
    
    @IBOutlet var menuButton: UIBarButtonItem!
    let contentURL = "http://www.brianjcoleman.com/tutorial-how-to-share-in-facebook-sdk-4-0-for-swift"
    let contentURLImage = "http://www.brianjcoleman.com/wp-content/uploads/2015/03/10734326_939301926101159_1211166514_n-667x333.png"
    let contentTitle = "Tutorial: How To Share in Facebook SDK 4.0 for Swift"
    let contentDescription = "In this tutorial learn how to integrate Facebook Sharing into your iOS Swift project using the native Facebook SDK 4.0."
    var imagePicker = UIImagePickerController()
    var mediaSelected = ""
    var button:FBSDKShareButton!


        override func viewDidLoad() {
    
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
            //showShareButtons()
                   super.viewDidLoad()
            
        }
    
    func showShareButtons()
    {
        self.showLinkButton()
        self.showPhotoButton()
        self.showVideoButton()
    }
    
    func showLinkButton()
    {
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: self.contentURL)
        content.contentTitle = self.contentTitle
        content.contentDescription = self.contentDescription
        content.imageURL = NSURL(string: self.contentURLImage)
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(button)
        
        let label : UILabel = UILabel()
        label.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 200) * 0.5, 25, 200, 25)
        label.text = "Link Example"
        label.textAlignment = .Center
        self.view.addSubview(label)
    }

    @IBAction func postButtonTapped(sender: AnyObject) {
        let shareToFacebook: SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
    }
    
    @IBAction func tweetButtonTapped(sender: AnyObject) {
        
        let shareToTwitter: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        self.presentViewController(shareToTwitter, animated: true, completion: nil)
    }

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock {(error: NSError?)-> Void in
            
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            
            let loginPageNav = UINavigationController(rootViewController: loginPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginPageNav
        }

    }
    
    func showPhotoButton()
    {
        let button : UIButton = UIButton()
        button.backgroundColor = UIColor.blueColor()
        button.setTitle("Choose Photo", forState: .Normal)
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 150) * 0.5, 125, 150, 25)
        button.addTarget(self, action: "photoBtnClicked", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        let label : UILabel = UILabel()
        label.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 200) * 0.5, 100, 200, 25)
        label.text = "Photos Example"
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
    
    func photoBtnClicked(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Photo capture")
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            self.mediaSelected = "Photo"
        }
        
    }

    func showVideoButton()
    {
        button = FBSDKShareButton()
        button.backgroundColor = UIColor.blueColor()
        button.setTitle("Choose Video", forState: .Normal)
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 150) * 0.5, 200, 150, 25)
        button.addTarget(self, action: "videoBtnClicked", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        let label : UILabel = UILabel()
        label.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 200) * 0.5, 175, 200, 25)
        label.text = "Video Example"
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
    
    func videoBtnClicked(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Video capture")
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            self.mediaSelected = "Video"
        }
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if self.mediaSelected == "Photo"
        {
            let photo : FBSDKSharePhoto = FBSDKSharePhoto()
            photo.image = info[UIImagePickerControllerOriginalImage] as! UIImage
            photo.userGenerated = true
            let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
            content.photos = [photo]
            FBSDKShareAPI.shareWithContent(content, delegate: nil)
            FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
            
            self.button.shareContent = content
        }
        
        if self.mediaSelected == "Video"
        {
            let video : FBSDKShareVideo = FBSDKShareVideo()
            video.videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
            let content : FBSDKShareVideoContent = FBSDKShareVideoContent()
            content.video = video
        }
        
        self.mediaSelected = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func shareButtonTapped(sender: AnyObject) {
        photoBtnClicked()
    }
}
