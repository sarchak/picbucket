//
//  ViewController.swift
//  picbucket
//
//  Created by Shrikar Archak on 11/1/14.
//  Copyright (c) 2014 Shrikar Archak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate {
   
    @IBOutlet weak var selectedImage: UIImageView!

    @IBAction func selectImage(sender: AnyObject) {
        
        /* Supports UIAlert Controller */
        if( controllerAvailable()){
            handleIOS8()
        } else {
            var actionSheet:UIActionSheet
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                actionSheet = UIActionSheet(title: "Hello this is IOS7", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"Select photo from library", "Take a picture")
            } else {
                actionSheet = UIActionSheet(title: "Hello this is IOS7", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"Select photo from library")
            }
            actionSheet.delegate = self
            actionSheet.showInView(self.view)
            /* Implement the delegate for actionSheet */
        }

    }
    
    func handleIOS8(){
        let imageController = UIImagePickerController()
        imageController.editing = false
        imageController.delegate = self;

        let alert = UIAlertController(title: "Lets get a picture", message: "Simple Message", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let libButton = UIAlertAction(title: "Select photo from library", style: UIAlertActionStyle.Default) { (alert) -> Void in
            imageController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imageController, animated: true, completion: nil)
        }
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let cameraButton = UIAlertAction(title: "Take a picture", style: UIAlertActionStyle.Default) { (alert) -> Void in
                println("Take Photo")
                imageController.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imageController, animated: true, completion: nil)
        
            }
            alert.addAction(cameraButton)
        } else {
            println("Camera not available")

        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
            println("Cancel Pressed")
        }
        
        alert.addAction(libButton)
        alert.addAction(cancelButton)
        
        /* Code for UIAlert View Controller
            let alert = UIAlertController(title: "This is an alert!", message: "Using UIAlertViewController", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
                println("Ok Selected")
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelSelected) -> Void in
                println("Cancel Selected")
            }
            alert.addAction(okButton)
            alert.addAction(cancelButton)
        */
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, nil)
        self.selectedImage.image = image;
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println("Title : \(actionSheet.buttonTitleAtIndex(buttonIndex))")
        println("Button Index : \(buttonIndex)")
        let imageController = UIImagePickerController()
        imageController.editing = false
        imageController.delegate = self;
        if( buttonIndex == 1){
            imageController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if(buttonIndex == 2){
            imageController.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            
        }
        self.presentViewController(imageController, animated: true, completion: nil)
    }
    
    func controllerAvailable() -> Bool {
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            return true;
        }
        else {
            return false;
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }

