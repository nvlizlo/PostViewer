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
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            //go to posts...
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SignUpViewController.self))
        navigationController?.show(signUpViewController, sender: self)
    }
    
}

