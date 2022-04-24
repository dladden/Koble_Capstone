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
    
    
    //var isActive: Bool = false//varibale for the signup button to create the imageUI change
    var isFemale = true//varibale for the female/male segment
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var genderSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
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
        //dateOfBirthTextField.layer.cornerRadius = 18
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
       
     
            
        
            if isTextDataInputed(){
                //regiter the user sectoin
                
                //confirming that the password is the same
                if passwordTextFeild.text! == confirmPasswordTextField.text!{
                    registerUser()//call register fucntion
                }else{
                    ProgressHUD.colorHUD = .purple
                    ProgressHUD.showError("passwords do not match ):")
                }//end if else
                registerUser()
                
            }else{
                ProgressHUD.colorHUD = .purple
                ProgressHUD.showError("please fill in all fields")
            }//end if else
            
            
            
        
        
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
        
        return usernameTextField.text != "" && emailTextField.text != "" && cityTextField.text != "" && passwordTextFeild.text != "" && confirmPasswordTextField.text != ""
        
    }
    
    //MARK: - RegisterUser
    //When function called user object should be registered
    private func registerUser(){
        //print(dateOfBirthPicker.date)
        //showing progress for the user
        ProgressHUD.show()

        //Forced Unwrapping function which checks if everything is entered
        FirebaseUser.registerUserWith(userName: usernameTextField.text!, email: emailTextField.text!, dateOfBirth: dateOfBirthPicker.date, isFemale: isFemale, city: cityTextField.text!, password: passwordTextFeild.text!, completion:{
            error in

            //ProgressHUD.dismiss()
            //print("callback")

            //chekicng if there was an error
            //if error is nill email is sent else show error
            //(error is forece unwrapped since it will have 1 as value)
            if error == nil{
                ProgressHUD.colorHUD = .purple
                ProgressHUD.showSuccess("verifiaction email sent!")
                self.dismiss(animated: true, completion: nil)//dismissing the create account ui
            }else{
                ProgressHUD.showError(error!.localizedDescription)
            }


        })
        
    }//end registerUser
    
    
}//end signupViewController


