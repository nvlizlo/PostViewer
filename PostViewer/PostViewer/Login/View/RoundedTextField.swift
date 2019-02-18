//
//  RoundedTextField.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/3/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        borderStyle = .none
        cornerRadius = frame.size.height / 2
        leftSpacer = 20
        font = UIFont.systemFont(ofSize: 28)
        backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1.0)
    }
}
