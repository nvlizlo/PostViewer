//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

protocol PostsView: class {
    func updateView()
    func updatePostAt(index: Int)
    func deletePost(index: Int)
}

class PostsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerReusableCell(PostTableViewCell.self)
        }
    }
    
    var presenter: PostsViewPresenter!
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PostsPresenter(view: self)
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
        controller.clos = { [weak self] text in
            self?.presenter.addPost(postText: text!)
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
        cell.editButtonClosure = { [weak self] in
            let controller = EditPostAlertViewController(nibName: "EditPostAlertViewController", bundle: nil)
            controller.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .overCurrentContext
            
            controller.clos = { [weak self] text in
                self?.presenter.updatePost(postText: text!, index: indexPath.row)
            }
            
            self?.present(controller, animated: false) {
                controller.postText = cell.postText
            }
        }
        
        cell.deleteButtonClosure = { [weak self] in
            self?.presenter.removePost(index: indexPath.row)
        }
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: PostsView {
    func updateView() {
        tableView.reloadData()
    }
    
    func updatePostAt(index: Int) {
        tableView.reloadRows(at: [[0, index]], with: .fade)
    }
    
    func deletePost(index: Int) {
        tableView.deleteRows(at: [[0, index]], with: .fade)
    }
}
