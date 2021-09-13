//
//  RegisterViewController.swift
//  LetsMeet
//
//  Created by Mavin on 9/12/21.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {

    
    //MARK: - IBOutlet
    @IBOutlet weak var usernameTextField  : UITextField!
    @IBOutlet weak var emailTextField     : UITextField!
    @IBOutlet weak var cityTextField      : UITextField!
    @IBOutlet weak var dobTextField       : UITextField!
    @IBOutlet weak var passwordTextField  : UITextField!
    @IBOutlet weak var confirmPwdTextField: UITextField!
    @IBOutlet weak var genderSegment      : UISegmentedControl!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - Vars
    var isMale = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configBackground()

      
    }
    
    //MARK: - Config
    func configBackground(){
        self.backgroundImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(disableKeybord))
        self.backgroundImageView.addGestureRecognizer(gesture)
    }
    
    @objc func disableKeybord(){
        self.view.endEditing(false)
    }
    
    //MARK: - IBActions
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if isAllFieldsInputed() {
            if passwordTextField.text! == confirmPwdTextField.text! {
                registerUser()
            }else{
                ProgressHUD.showError("Password doesn't match!")
            }
        }else{
            ProgressHUD.showError("All fields are required")
        }
        
    }
    
   
    @IBAction func segmentChangeValues(_ sender: UISegmentedControl) {
        isMale = sender.selectedSegmentIndex == 0 
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func isAllFieldsInputed () -> Bool {
        return usernameTextField.text != "" && emailTextField.text != "" && cityTextField.text != "" && dobTextField.text != "" && passwordTextField.text != "" && confirmPwdTextField.text != ""
    }
    
    
    //MARK: - RegisterUser
    private func registerUser(){
        
        ProgressHUD.show()
        
        FUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, userName: usernameTextField.text!, city: cityTextField.text!, isMale: isMale, dateOfBirth: Date()) { error in
            if error == nil {
                ProgressHUD.showSuccess("Verification email sent!")
                self.dismiss(animated: true, completion: nil)
            }else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        }
    }
    
}
