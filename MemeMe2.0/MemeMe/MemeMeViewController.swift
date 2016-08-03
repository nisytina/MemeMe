//
//  ViewController.swift
//  MemeMe
//
//  Created by Tina Ni on 4/5/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var saveToolBar: UIToolbar!
    @IBOutlet weak var pickToolBar: UIToolbar!
    @IBOutlet weak var pickLabel: UILabel!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var memedImage: UIImage!
    var meme: Meme!
    var topbeginEditing = false
    var bottombeginEditing = false
    var topEditing = false
    var bottomEditing = false
    var editFromViews = false
    var image: UIImage!
    var topText: String!
    var bottomText: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: to check whether the source type camera is available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // MARK: abstract setting textfield attribute into a function
        setTextFieldAttribute(top)
        setTextFieldAttribute(bottom)
        
        top.hidden = true
        bottom.hidden = true
        shareButton.enabled = false
        
        //When the viewController is presented from table or collection viw controller
        if editFromViews == true {
            editMode()
            top.text = topText
            bottom.text = bottomText
            imagePickerView.image = image
            pickToolBar.hidden = false
        }
        
    }
    
    func setTextFieldAttribute(textField: UITextField) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : NSNumber.init(float: -3.0)
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.delegate = self
    }
    
    func initForEditing() {
        top.text = "TOP"
        bottom.text = "BOTTOM"
        topbeginEditing = false
        bottombeginEditing = false
        topEditing = false
        bottomEditing = false
        shareButton.enabled = true
    }
    
    func hideToolBars(hidden: Bool) {
        pickToolBar.hidden = hidden
        saveToolBar.hidden = hidden
    }
    
    func editMode () {
        
        initForEditing()
        top.hidden = false
        bottom.hidden = false
        //set saveToolBar's height back to 44 when the orientation is Landscape
        let orient = UIApplication.sharedApplication().statusBarOrientation
        setToolBarFrame(orient)
        pickLabel.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //When the viewController is presented from table or collection viw controller
        subscribeToKeyboardNotificationsAndHide()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        let orient = UIApplication.sharedApplication().statusBarOrientation
        setToolBarFrame(orient)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotificationsAndHide()
    }
    
    
    func subscribeToKeyboardNotificationsAndHide() {
        //keyboard notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeMeViewController.keyboardWillShow(_:))    , name: UIKeyboardWillShowNotification, object: nil)
        
        //will hide keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeMeViewController.keyboardWillHide(_:))    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotificationsAndHide() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        //hide keyboard
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    //cancel selecting a picture
    func imagePickerControllerDidCancel(pickerController: UIImagePickerController){
        
        pickerController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        // counter increments whenever keyborad toggles
        if bottom.isFirstResponder(){
            // avoid compound increment opperator
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottom.isFirstResponder(){
            // 0 is the original y location
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func setKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        if bottomEditing {
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.restorationIdentifier == "top" {
            if topbeginEditing == false {
                textField.text = nil
                self.topbeginEditing = true
                
            }
            self.topEditing = true
        }
        else if textField.restorationIdentifier == "bottom" {
            if bottombeginEditing == false {
                textField.text = nil
                self.bottombeginEditing = true
                
            }
            self.bottomEditing = true
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.topEditing = false
        self.bottomEditing = false
        return true
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.sharedApplication().statusBarOrientation
            
            switch orient {
            case .LandscapeLeft:
                self.saveToolBar.frame.size.height = 44
            // Do something
            case .LandscapeRight:
                self.saveToolBar.frame.size.height = 44
            default:
                self.saveToolBar.frame.size.height = 60
            }
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                print("rotation completed")
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    
    func setToolBarFrame(rotation: UIInterfaceOrientation) {
        
        if rotation == .LandscapeLeft || rotation == .LandscapeRight {
            self.saveToolBar.frame.size.height = 44
        }
    }
    
    
    
    //pick an image as the original one
    func imagePickerController(picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = image
            editMode()
            
    }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func pickImage (sourceType: UIImagePickerControllerSourceType) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        self.presentViewController(pickerController, animated: true, completion:nil)
    }
    
    //pick a picture from the album
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        pickImage(.PhotoLibrary)
    }
    
    //pick a picture from the camera
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        
        //if sourcetype camera is available, then the button is enabled
        if cameraButton.enabled == true {
            pickImage(.Camera)
        }
    }
    
    //generate memed Image
    func generateMemedImage() -> UIImage
    {
        //hide tool bar and nav bar
        hideToolBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show tool bar and nav bar
        hideToolBars(false)
        
        return memedImage
    }
    
    //generte a meme object
    func save() {
        
        meme = Meme(topText:top.text!, bottomText:bottom.text!, image: imagePickerView.image, memedimage: self.memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        self.memedImage = generateMemedImage()
        let activity  = UIActivityViewController.init(activityItems: [self.memedImage] , applicationActivities: nil)
        //If the user completes an action in the activity view controller,
        //save the meme to the shared storage.
        activity.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
       self.presentViewController(activity, animated: true, completion: nil)
    }
    
    
    
    //hide top and bottom textfields and toolbars
    @IBAction func cancelMeme(sender: AnyObject) {
        initForEditing()
        top.hidden = true
        bottom.hidden = true
        shareButton.enabled = true
        pickLabel.hidden = false
        imagePickerView.image = nil
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

