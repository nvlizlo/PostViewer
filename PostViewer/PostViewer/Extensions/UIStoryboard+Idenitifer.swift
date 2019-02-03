//
//  UIStoryboard+Main.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 2/3/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: type.self)) as? T
    }
}
