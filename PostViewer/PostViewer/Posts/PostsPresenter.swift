//
//  PostsPresenter.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

class PostsPresenter {
    private var posts: [Post]
    weak var presentable: PostPresentable?
    
    init(presentable: PostPresentable) {
        self.presentable = presentable
        self.posts = [Post]()
    }
    
    func loadPosts() {
        let ref = Database.database().reference(withPath: "posts")
        
        ref.observe(.value) { snapshot in
            for child in snapshot.children {
                if let snaphot = child as? DataSnapshot {
                    let post = Post(snapshot: snaphot)
                    self.posts.append(post!)
                }
            }
            self.presentable?.updateView()
        }
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func postAt(index: Int) -> Post {
        return posts[index]
    }
}
