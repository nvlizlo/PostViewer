//
//  ViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 12/22/18.
//  Copyright © 2018 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

protocol LoginPresentable: class {
    func updateView(isLoginState: Bool)
    func showPosts()
}

class LoginViewController: UIViewController {
    
    //MARK: Constants
    private enum Constants {
        static let signInButtonTitle = "Sign In"
        static let signUpButtonTitle = "Sign Up"
        static let dontHaveAccountTitle = "Don't have an account?"
        static let alreadyHaveAccountTitle = "Already have an account?"
    }
    
    //MARK: IBOutlets
    @IBOutlet private weak var emailTextField: RoundedTextField!
    @IBOutlet private weak var nameTextField: RoundedTextField!
    @IBOutlet private weak var passwordTextField: RoundedTextField!
    @IBOutlet private weak var repeatPasswordTextField: RoundedTextField!
    
    @IBOutlet var textFields: [RoundedTextField]! {
        didSet {
            textFields.last?.returnKeyType = .go
        }
    }
    
    @IBOutlet private weak var signInUpButton: UIButton!
    @IBOutlet private weak var haveAccountlabel: UILabel!
    @IBOutlet private weak var toggleButton: UIButton!
    
    var presenter: LoginPresenter!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(presentable: self)
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.showPosts()
            }
            
        }
    }
    
    //MARK: IBActions
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text,
            let name = nameTextField.text,
            let password = passwordTextField.text,
            let repeatPassword = repeatPasswordTextField.text else {
            return
        }
        
        presenter.signInClicked(email: email, name: name, password: password, repeatPassword: repeatPassword)
    }
    
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
        (self.nameTextField.isHidden, self.repeatPasswordTextField.isHidden) = (self.presenter.isLoginState, self.presenter.isLoginState)
        UIView.animate(withDuration: 0.5, animations: {
            self.nameTextField.alpha = self.presenter.isLoginState ? 1 : 0
            self.repeatPasswordTextField.alpha = self.presenter.isLoginState ? 1 : 0
        }) { completed in
        }
        
        presenter.isLoginState = !presenter.isLoginState
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField as? RoundedTextField {
            let index = textFields.firstIndex(of: textField)
            if index! < textFields.count - 1 {
                textFields[index! + 1].becomeFirstResponder()
            } else {
                //sign in or sign up...
            }
        }
        return true
    }
}

extension LoginViewController: LoginPresentable {
    func updateView(isLoginState: Bool) {
        toggleButton.setTitle(isLoginState ? Constants.signUpButtonTitle : Constants.signInButtonTitle, for: .normal)
        signInUpButton.setTitle(isLoginState ? Constants.signInButtonTitle : Constants.signUpButtonTitle, for: .normal)
        haveAccountlabel.text = isLoginState ? Constants.dontHaveAccountTitle : Constants.alreadyHaveAccountTitle
        (nameTextField.isHidden, repeatPasswordTextField.isHidden) = (isLoginState, isLoginState)
    }
    
    func showPosts() {
        guard let postsViewController = UIStoryboard.main.instantiateViewController(PostsViewController.self) else {
            return
        }
        navigationController?.show(postsViewController, sender: self)
    }
}

