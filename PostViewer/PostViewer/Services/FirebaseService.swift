//
//  FirebaseService.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 2/4/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService<T: DataSnapshotable> {
    typealias LoadItemsCallbback = ([T]) -> Void
    
    enum Item: String {
        case posts = "posts"
    }
    
    let databaseRef = Database.database()
    
    func loadItems(_ itemsKey: Item, orderedBy orderKey: String = "", callback: LoadItemsCallbback?) {
        let ref = databaseRef.reference(withPath: itemsKey.rawValue)
        ref.queryOrdered(byChild: orderKey).observe(.value) { snapshot in
            var posts = [T]()
            for child in snapshot.children {
                if let snaphot = child as? DataSnapshot {
                    let post = T(dataSnapshot: snaphot)
                    posts.append(post!)
                }
            }
            callback?(posts)
        }
    }
    
    func addItem(_ itemKey: Item, postText: String) {
        let ref = databaseRef.reference(withPath: itemKey.rawValue)
        let post = Post(text: postText, dateCreated: Date())
        let postRef = ref.child(postText)
        postRef.setValue(post.toAnyObject())
    }
}
