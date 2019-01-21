//
//  PostsPresenter.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation

class PostsPresenter {
    private var posts: [Post]!
    
    func numberOfPosts() -> Int {
        return posts.count ?? 0
    }
    
    func postAt(index: Int) -> Post {
        return posts[index]
    }
}
