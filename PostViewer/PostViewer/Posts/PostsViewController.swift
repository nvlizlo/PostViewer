//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

protocol PostPresentable: class {
    func updateView()
}

class PostsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerReusableCell(PostTableViewCell.self)
        }
    }
    
    var presenter: PostsPresenter!
    let ref = Database.database().reference(withPath: "posts")
    var posts = [Post]()
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PostsPresenter(presentable: self)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadPosts()
    }

    //MARK: IBActions
    @objc func addPost() {
        let controller = EditPostAlertViewController(nibName: "EditPostAlertViewController", bundle: nil)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        controller.clos = { text in
            self.presenter.addPost(postText: text)
        }
        
        self.present(controller, animated: false)
    }
}

private extension PostsViewController {
    func setupView() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PostTableViewCell
        cell.postText = presenter.postAt(index: indexPath.row).text
        cell.editButtonClosure = {
            let controller = EditPostAlertViewController(nibName: "EditPostAlertViewController", bundle: nil)
            controller.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .overCurrentContext
            
            controller.clos = { text in
                cell.postText = text
            }
            
            self.present(controller, animated: false, completion: {
                controller.postText = cell.postText
            })
        }
        
        cell.deleteButtonClosure = {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: PostPresentable {
    func updateView() {
        tableView.reloadData()
    }
}
