//
//  Post.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

protocol DataSnapshotable {
    init?(dataSnapshot: DataSnapshot)
}

struct Post {
    
    enum Keys {
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
    
    func toAnyObject() -> Any {
        return [
            Keys.text : text,
            Keys.dateCreated : Post.dateFormatter.string(from: dateCreated)
        ]
    }
}

extension Post: DataSnapshotable {
    init?(dataSnapshot: DataSnapshot) {
        if let value = dataSnapshot.value as? [String: AnyObject],
            let text = value[Keys.text] as? String,
            let dateString = value[Keys.dateCreated] as? String,
            let dateCreated = Post.dateFormatter.date(from: dateString) {
            self.text = text
            self.dateCreated = dateCreated
        } else {
            return nil
        }
    }
}
