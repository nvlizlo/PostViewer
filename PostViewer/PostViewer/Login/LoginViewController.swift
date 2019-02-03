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
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var textFields = [UITextField]()
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [emailTextField, passwordTextField]
    }
    
    //MARK: IBActions
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error == nil {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let postsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: PostsViewController.self))
                self?.navigationController?.show(postsViewController, sender: self)
            }
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SignUpViewController.self))
        navigationController?.show(signUpViewController, sender: self)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let index = textFields.firstIndex(of: textField)
        if index! < textFields.count - 1 {
            textFields[index! + 1].becomeFirstResponder()
        }
        return true
    }
}

