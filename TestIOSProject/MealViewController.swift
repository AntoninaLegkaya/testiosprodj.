//
//  MealViewController.swift
//  TestIOSProject
//
//  Created by User on 10.04.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,  UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var enterMealName: UITextField!
    @IBOutlet weak var setNameMealButton: UIButton!

    @IBOutlet weak var imageHolder: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    // This value is either passed by "MealTableViewController" in 'prepare(for:sender)'
    // or constructed as part of adding a new meal
    
    var meal: Meal?
    
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
            super.viewDidLoad()
            // Handle the text field’s user input through delegate callbacks
            enterMealName.delegate = self
        
        enterMealName.attributedPlaceholder =
            NSAttributedString(string: "Enter you value", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        // Set up views if editing an existing Meal
        if let meal = meal{
            navigationItem.title = meal.name
            enterMealName.text = meal.name
            imageHolder.image = meal.photo
            ratingControl.rating = meal.rating
            print("Init Rating-> \(ratingControl.rating)")
        }
        // Enable the Save Button only if the text field has a valid Meal name
        updateSaveButtonState()    }

    // MARK:UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //MARK: resign the text field’s first-responder status
            // Hide the keyboard.
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
    // MARK: method gives you a chance to read the information entered into the text field and do //something with it
            updateSaveButtonState()
            navigationItem.title = textField.text
    }
    // editing session begins or when the keyboard gets displayed
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable save button while editing
        saveButton.isEnabled = false
    }
        
        @IBAction func setMealNameAction(_ sender: UIButton) {
          //  defaultMealLabel.text=enterMealName.text
            navigationItem.title = enterMealName.text
            updateSaveButtonState()
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
             
             // Hide the keyboard
             enterMealName.resignFirstResponder()
             let imagePickerController = UIImagePickerController()
             // Only allow photos to be picked not taken
             imagePickerController.sourceType = .photoLibrary
             // Make shure ViewController is notified when the user picks an image
             imagePickerController.delegate = self
             // method ask ViewController to present the view controller defined by imagePickerController ->animated: true  animated the presentation of the image picker controller
             // completion-> refers  to completion handler, a pice of code that executes after this method completes. In this case we don't need do execute a completion handler
             present(imagePickerController, animated: true, completion: nil)
         }
 
    // To give users the ability to select a picture? need to implement two of the delegate methods define in UIImagePickerControllerDeligate
    //gets call when a user taps the image picker's Cancel btn; this methods gives chance to dismiss the UIImagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // dismiss the picker if the user cancel
        dismiss(animated: true, completion: nil)
    }
    
    // gets call when the user selects a photo -> do smth with photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageHolder.contentMode = UIView.ContentMode.scaleAspectFit
        // The info dictionary may contain multiple representations of the image. You want to use the origin
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage else {
                 fatalError("Expected a dictionary containing an image? but was provided the following: \(info)")
        }
        
        imageHolder.image = selectedImage
        
        dismiss(animated: true, completion: nil) 
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depend on style of presentation (modal or push presentation), this view controller
        // need to be dismiss in two different ways
        let isPresentatingInAddMealMode = presentingViewController is UINavigationController
        if isPresentatingInAddMealMode{
            dismiss(animated: true, completion: nil)}
        else if  let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else{
             fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    // This method lets you configure a view controller befor it's presented
    // this method verifies that the sender is button and than uses the identity operator(===) to check that the object referenced by the sender and the saveButton outlet are the same
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, canceling", log: OSLog.default, type: .debug)
            
            return
        }
        let name = enterMealName.text ?? ""
        let photo = imageHolder.image
        let rating = ratingControl.rating
        
        
   
        // Set the meal tobe passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    //MARK: Private Methods
    
  
    private func updateSaveButtonState(){
        //Display the Save Button if the text field is empty
        let text = enterMealName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }

 
}

