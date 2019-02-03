//
//  LoginPresenter.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 2/3/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

class LoginPresenter {
    weak var presentable: LoginPresentable?
    
    var isLoginState = true {
        didSet {
            presentable?.updateView(isLoginState: isLoginState)
        }
    }
    
    init(presentable: LoginPresentable) {
        self.presentable = presentable
    }
    
    func signInClicked(email: String, name: String, password: String, repeatPassword: String) {
        if isLoginState {
            signIn(email: email, password: password)
        } else {
            signUp(email: email, name: name, password: password, repeatPassword: repeatPassword)
        }
    }
    
    private func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard error == nil else {
                return
            }
            self?.presentable?.showPosts()
        }
    }
    
    private func signUp(email: String, name: String, password: String, repeatPassword: String) {
        if password == repeatPassword {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] dataResult, error in
                guard let user = dataResult?.user, error == nil else {
                    return
                }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    print("error")
                }
                self?.presentable?.showPosts()
            }
        }
    }
    
}
