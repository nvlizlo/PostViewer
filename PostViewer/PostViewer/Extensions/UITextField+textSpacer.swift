//
//  UITextField+textSpacer.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/3/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable public var leftSpacer: CGFloat {
        get {
            return leftView?.frame.size.width ?? 0
        }
        set {
            leftViewMode = .always
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
        }
    }
}
