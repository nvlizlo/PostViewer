//
//  EditPostAlertViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/22/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class EditPostAlertViewController: UIViewController {
    
    @IBOutlet private weak var postTextView: UITextView!
    @IBOutlet private weak var editPostButton: UIButton!
    @IBOutlet private weak var cancelEditPostButton: UIButton!
    
    var postText: String {
        set {
            postTextView.text = newValue
        }
        get {
            return postTextView.text
        }
    }
    
    var clos: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurFx = UIBlurEffect(style: .prominent)
        let blurFxView = UIVisualEffectView(effect: blurFx)
        blurFxView.frame = view.bounds
        blurFxView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurFxView, at: 0)
    }
    
    @IBAction func editPostButtonClicked(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.clos?(self?.postText)
        }
    }
    
    @IBAction func cancelEditPostButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
