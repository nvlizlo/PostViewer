//
//  ViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 12/22/18.
//  Copyright © 2018 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                print("success")
            }
        }
    }
    
}

