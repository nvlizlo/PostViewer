//
//  Post.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    
    private enum Keys {
        static let text = "text"
        static let dateCreated = "dateCreated"
    }
    
    let text: String
    let dateCreated: Date
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter
    }
    
    init(text: String, dateCreated: Date) {
        self.text = text
        self.dateCreated = dateCreated
    }
    
    init?(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: AnyObject] {
            self.text = value[Keys.text] as! String
            
            self.dateCreated = Post.dateFormatter.date(from: value[Keys.dateCreated] as! String)!
        } else {
            return nil
        }
    }
    
    func toAnyObject() -> Any {
        return [
            Keys.text : text,
            Keys.dateCreated : Post.dateFormatter.string(from: dateCreated)
        ]
    }
}
