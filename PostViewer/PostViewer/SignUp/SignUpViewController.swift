//
//  SignUpViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 12/28/18.
//  Copyright © 2018 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: IBActions
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let repeatPassword = repeatPasswordTextField.text else {
            return
        }
        if password == repeatPassword {
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    print("success")
                }
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
    }
    
}
