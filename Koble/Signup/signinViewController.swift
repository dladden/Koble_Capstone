//
//  signinViewController.swift
//  Koble
//
//  Created by Denys Ladden on 4/9/22.
//

import UIKit
import ProgressHUD//Pod Libarary Alows to show Errors

class signinViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //bakground image for koble
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //button styling
        emailTextField.layer.cornerRadius = 18
        passwordTextField.layer.cornerRadius = 18
        
        setupBackgroundTouch()
        
       
    }
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            
            FirebaseUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVarified) in
                //if there are an erros since it would be not nill
                if error != nil {
                    
                    ProgressHUD.showError(error!.localizedDescription)
                    
                }else if isEmailVarified {
                    
                    //enter the application
                    print("user enters the app")
                }else{
                    
                    ProgressHUD.showError("Please verify your email ")
                    
                }
                
            }//end firbase login user
            
        }else{
            //show error
            ProgressHUD.showError("please add your email and password")
        }//end else
        
        
    }//end login function
    
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
        if emailTextField.text != ""{
            //then reset the password
            
        }else{
            //show error
            ProgressHUD.showError("please type in your email")
        }
    }//end forgotPasswordButtonPressed
    
    
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
    
    
    
    
    
}//end class signinViewController
