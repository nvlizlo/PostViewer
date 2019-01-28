//
//  PostTableViewCell.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> Void

class PostTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var deletePostButton: UIButton!
    @IBOutlet private weak var editPostButton: UIButton!
    
    var postText: String {
        set {
            messageTextView.text = newValue
        }
        
        get {
            return messageTextView.text
        }
    }
    var editButtonClosure: VoidClosure?
    var deleteButtonClosure: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func editButtonPressed(_ sender: UIButton) {
        editButtonClosure?()
    }
    
    @IBAction private func deleteButtonPressed(_ sender: UIButton) {
        deleteButtonClosure?()
    }
    
}
