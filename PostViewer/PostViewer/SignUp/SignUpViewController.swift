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
    
    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBActions
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let repeatPassword = repeatPasswordTextField.text else {
            return
        }
        if password == repeatPassword {
            Auth.auth().createUser(withEmail: email, password: password) { dataResult, error in
                guard let user = dataResult?.user, error == nil else {
                    return
                }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self.nameTextField.text
                changeRequest.commitChanges { error in
                    print("error")
                }
                //go to posts...
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
