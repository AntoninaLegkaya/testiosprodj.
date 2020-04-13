//
//  ViewController.swift
//  TestIOSProject
//
//  Created by User on 10.04.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var defaultMealLabel: UILabel!
    @IBOutlet weak var enterMealName: UITextField!
    @IBOutlet weak var setNameMealButton: UIButton!
    @IBOutlet weak var imageHolder: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
            super.viewDidLoad()
            // Handle the text field’s user input through delegate callbacks
            enterMealName.delegate = self
        
        enterMealName.attributedPlaceholder =
            NSAttributedString(string: "Enter you value", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])        }

    // MARK:UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //MARK: resign the text field’s first-responder status
            // Hide the keyboard.
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
    // MARK: method gives you a chance to read the information entered into the text field and do //something with it
            defaultMealLabel.text = textField.text
        }
        
        @IBAction func setMealNameAction(_ sender: UIButton) {
            defaultMealLabel.text=enterMealName.text
            
        }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        enterMealName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        // Make shure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        // method ask ViewController to present the view controller defined by imagePickerController ->animated: true animated the presentation of the image picker controller
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
        
        // The info dictionary may contain multiple representations of the image. You want to use the origin
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage else {
                 fatalError("Expected a dictionary containing an image? but was provided the following: \(info)")
        }
        imageHolder.image = selectedImage
        dismiss(animated: true, completion: nil) 
    }
    


}

