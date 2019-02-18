//
//  PostsPresenter.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

protocol PostsViewPresenter: class {
    func numberOfPosts() -> Int
    func postAt(index: Int) -> Post
    func loadPosts()
    
    func addPost(postText: String)
    func removePost(index: Int)
    func updatePost(postText:String, index: Int)
}

class PostsPresenter {
    private var posts: [Post]
    private weak var view: PostsView?
    
    init(view: PostsView) {
        self.view = view
        self.posts = [Post]()
    }
}

extension PostsPresenter: PostsViewPresenter {
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func postAt(index: Int) -> Post {
        return posts[index]
    }
    
    func loadPosts() {
        FirebaseService<Post>().loadItems(FirebaseService.Item.posts, orderedBy: Post.Keys.text) { items in
            self.posts = items
            self.view?.updateView()
        }
    }
    
    func addPost(postText: String) {
        FirebaseService<Post>().addItem(FirebaseService.Item.posts, postText: postText)
    }
    
    func removePost(index: Int) {
        let deletedPost = postAt(index: index)
        FirebaseService<Post>().removeItem(deletedPost)
        view?.updatePostAt(index: index)
    }
    
    func updatePost(postText: String, index: Int) {
        let updatedPost = postAt(index: index)
        FirebaseService<Post>().updateItem(updatedPost, values: [Post.Keys.text: postText])
        view?.updatePostAt(index: index)
    }
}
