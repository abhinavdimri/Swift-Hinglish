//
//  ViewController.swift
//  Hinglish
//
//  Created by Abhinav Dimri on 22/11/15.
//  Copyright © 2015 Abhinav Dimri. All rights reserved.
//

import UIKit


var letterChanged = true

class ViewController: UIViewController, UISearchBarDelegate {
    
    //labels
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    //view and controls
    
    @IBOutlet weak var textInputView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //searchbar
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //suggestions
    
    @IBOutlet weak var suggestOne: UILabel!
    @IBOutlet weak var suggestTwo: UILabel!
    
    //animate
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    var hinglish = HinglishController()
    var hindi = HindiController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard show notification - KVO
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        //keyboard hide notification - KVO
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        
        //hide the uiview
        self.textInputView.layer.cornerRadius = 20.0
        self.textInputView.layer.masksToBounds = false
        self.textInputView.hidden = true
        
        //delegation for the searchviewcontroller
        searchBar.delegate = self
        
        //hide labels
        self.suggestOne.hidden = true
        self.suggestTwo.hidden = true
        
    }
    
    func keyboardDidShow(notification: NSNotificationCenter){
      
        //simple fade out animation
        
        UIView.animateWithDuration(1) { () -> Void in
            self.headingLabel.alpha = 0.0
            self.infoLabel.alpha = 0.0
        }
      
    }
    
    func keyboardDidHide(notification: NSNotificationCenter){
        
         //simple fade in animation
        UIView.animateWithDuration(1) { () -> Void in
            self.headingLabel.alpha = 0.0
            self.infoLabel.alpha = 0.0
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        let viewShadow = UIBezierPath(rect: textInputView.bounds)
        textInputView.layer.shadowColor = UIColor.blackColor().CGColor
        textInputView.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        textInputView.layer.shadowOpacity = 0.2
        textInputView.layer.shadowPath = viewShadow.CGPath
        
    }
    
    //not needed for now
    @IBAction func segmentedControl(sender: AnyObject) {
      
    }
    
    //hide keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        hidePresentingView()
    }
    
    //hide UIView with fadeout animation
    
    func hidePresentingView(){
      UIView.animateWithDuration(1, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
        self.textInputView.alpha = 0
        }) { (finished) -> Void in
            self.headingLabel.alpha = 1
            self.infoLabel.alpha = 1
            self.headingLabel.hidden = false
            self.infoLabel.hidden = false
        }
        

        
    }
    
    //searchbar delegate methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let word = searchBar.text else {return}
        showUIView()
        showHindiTranslation(word)
        letterChanged = true
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextShouldBeginEditing(searchBar: UISearchBar) {
    }
    
    
    //functions for manipulating the search results
    
    func showUIView(){
        textInputView.hidden = false
        
        UIView.animateWithDuration(2, delay: 0.2, options: .CurveEaseOut, animations: {
            self.textInputView.alpha = 1
            }, completion: nil)
    }
    
    //displays the word translated
    func showHindiTranslation(word: String){
       
        //showing labels
        self.suggestOne.hidden = false
        self.suggestTwo.hidden = false
        
        if segmentedControl.selectedSegmentIndex == 0{
            (self.suggestOne.text!, self.suggestTwo.text!) = hindi.constructHindiWord(word.lowercaseString)
        }else if segmentedControl.selectedSegmentIndex == 1{
            if self.hinglish.searchModelForWord(word.uppercaseString){
                self.suggestOne.text = hinglish.translatedWord
                self.suggestTwo.hidden = true
            }else {
                //No word was found the English Model, try translating.
                hinglish.transliterate(word.uppercaseString)
                self.suggestOne.text = hinglish.translatedWord
                self.suggestTwo.hidden = true
            }
        }
    }




}

