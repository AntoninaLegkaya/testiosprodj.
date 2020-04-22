//
//  RatingControl.swift
//  TestIOSProject
//
//  Created by User on 10.04.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    

    //MARK: Private Methods:
    
    private func setupButtons(){
        
        // clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load button images
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount   {
            
            
        //create button
        let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        // Setup the button action
        //addTarget(_, action:, for: ) -> attaching ratingButtonTapped(_:) action method to the button, which will be triggered whenever the .TouchDown event occures
        // self-> which referes to the current instance of the enclosing class? in this case? it refers to the RatingControl object that is setting up the button
        // #selector-> expression returns the Selector value for the provided method. Newer API have largly replaced selector with block. This expression returns selector for ratingButtonTapped(_:) action method it lets the sysytem call action method when the button is tapped
        // UIControlEvents-> set defines a number of event that controls can respond to; typically .touchUpInside -> occurs when user touches the button and then lifts their finger while the finger is stiil within with button's bounds. This Event has advantage over .touchDown? because the user can cancel the event by dragging their finger outside the button before lifting it

        button.addTarget(self, action:
            #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // Add constraints
        // disable automatically generated constraints if you add view in stack view? the stack automatically sets the view property translatesAutoresizingMaskIntoConstraints = false
            
        button.translatesAutoresizingMaskIntoConstraints = false
        // defined height button
           button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        // defined width button isActive=true -> adds constraint to the correct view and ectivates it
           button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
              //set the accessability label
                      button.accessibilityLabel = "Set \(index + 1) star rating"
            
        // Add the button to the stack (adds button to the list of views managed by the RatingControl stack view)
          addArrangedSubview(button)
            
        // Add the new button to the rating button array
        ratingButtons.append(button)
        
    }
        updateButtonSelectionStates()
        
        
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    
    @objc private func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not inthe ratingButtons array: \(ratingButtons)")
        }
        // calculate the rating of the selected button
        let selectedRating = index+1
        
        if selectedRating == rating {
            // If the selected star represents the current rating? reset the rating to 0
            rating = 0
        } else {
            //Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            
            // If the index of a button is less than the rating, that button should be selected.
            
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else{
                hintString = nil
            }
            // Calculate the value string
            let valuesString: String
            switch (rating) {
            case 0:
                valuesString = "No rating set"
            case 1:
                valuesString = "1star set."
            default:
                valuesString = "\(rating) stars set"
            }
            button.accessibilityHint = hintString
            button.accessibilityValue = valuesString
            
        }
    }
    
    
    // MARK: Properties
    
    //contains the list of buttons
     private var ratingButtons = [UIButton]()
    
    // contains the cintrol's rating
    var rating = 0{
        didSet{
            
            updateButtonSelectionStates()
            
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
           
           // Observe property; the didSet() is called immediatly after the property's value is set
           didSet{
               setupButtons()
           }
       }
       @IBInspectable var starCount: Int = 5 {
           
           didSet{
               setupButtons()
           }
       }
}
