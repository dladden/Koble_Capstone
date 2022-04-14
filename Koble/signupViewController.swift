//
//  signupViewController.swift
//  Koble
//
//  Created by Denys Ladden on 4/9/22.
//  Swift Tips:
//  ? = then
//  : = else

import UIKit
import ProgressHUD

class signupViewController: UIViewController {

    //MARK: - Vars
    var isActive: Bool = false//varibale for the signup button to create the imageUI change
    var isFemale = true//varibale for the female/male segment
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var genderSegmentedOutlet: UISegmentedControl!
    
    //password
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var changeImageSignupButton: UIButton!
    
    //background image
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - IBActions
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.layer.cornerRadius = 18
        emailTextField.layer.cornerRadius = 18
        dateOfBirthTextField.layer.cornerRadius = 18
        cityTextField.layer.cornerRadius = 18
        
        passwordTextFeild.layer.cornerRadius = 18
        confirmPasswordTextField.layer.cornerRadius = 18
        
        setupBackgroundTouch()
        
        
    }//end viewDidLoad
    
    //MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
       
        //button action
        if isActive{
            isActive = false
            changeImageSignupButton.setImage(UIImage(named: "signup_button02.svg"), for: .normal)
        }else{
            isActive = true
            changeImageSignupButton.setImage(UIImage(named: "signup_button_pressed.svg"), for: .normal)
            
        
            if isTextDataInputed(){
                //regiter the user
                registerUser()
                
            }else{
                ProgressHUD.showError("please fill in all fields")
            }
            
            
            
        }
        
    }//end registerButtonPressed
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func genderSegmentValueChange(_ sender: UISegmentedControl) {
        /*
        if sender.selectedSegmentIndex == 0{
            isFemale = true
        }else{
            isFemale = false
        }
         *///this short if statement is the same as the conditional below:
        isFemale = sender.selectedSegmentIndex == 0
        print(isFemale)
    }
    //MARK: - Setup
    private func setupBackgroundTouch(){
        
        backgroundImageView.isUserInteractionEnabled = true //user can interact with this view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        backgroundImageView.addGestureRecognizer(tapGesture)
        
    }//end setupBackgroundTouch
    
    
    @objc func backgroundTap(){
        
        dismissKeyboard()
        
    }//end backgroundTap

    //MARK: - Helpers
    
    private func dismissKeyboard(){
        self.view.endEditing(false)
       
    }//end dismissKeyboard
    
    //function which returns boolean (->)
    //this function makes sure that all fields are filled out
    private func isTextDataInputed() -> Bool {
        
        return usernameTextField.text != "" && emailTextField.text != "" && dateOfBirthTextField.text != "" && cityTextField.text != "" && passwordTextFeild.text != "" && confirmPasswordTextField.text != ""
        
    }
    
    //MARK: - RegisterUser
    //When function called user object should be registered
    private func registerUser(){
        //Forced Unwrapping
        FirebaseUser.registerUserWith(userName: usernameTextField.text!, email: emailTextField.text!, dateOfBirth: Date(), isFemale: isFemale, city: cityTextField.text!, password: passwordTextFeild.text!, completion:{
            error in
            
            print("callback")
            
        })
        
    }//end registerUser
    
    
}//end signupViewController


