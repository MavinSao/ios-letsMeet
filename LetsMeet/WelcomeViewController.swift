//
//  WelcomeViewController.swift
//  LetsMeet
//
//  Created by Mavin on 9/12/21.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField   : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Override Background to dark mode
        overrideUserInterfaceStyle = .dark
        setUpBackgroundTouch()
        
        
    }
    
    //MARK: - Setup
    func setUpBackgroundTouch(){
        backgroundImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
    
        backgroundImageView.addGestureRecognizer(gesture)
    }
    
    @objc func backgroundTap(){
        dismissKeyboard()
    }
    
    
    //MARK: - Helpers
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    
    //MARK: - IBActions
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        if emailTextField.text != "" {
            //forget password
        }else{
            ProgressHUD.showError("Please input your Email")
        }
        
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            //Login Process
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                }else if isEmailVerified{
                    //Enter App
                    print("Go to APP")
                }else{
                    ProgressHUD.showError("Please Verify Your Email")
                }
            }
        }else{
            ProgressHUD.showError("All Fields are required")
        }
    }
    
    
    
}
