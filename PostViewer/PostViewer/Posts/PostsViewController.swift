//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 1/7/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

class PostsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerReusableCell(PostTableViewCell.self)
        }
    }
    
    var presenter: PostsPresenter!
    let ref = Database.database().reference(withPath: "posts")
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    //MARK: IBActions
}

private extension PostsViewController {
    func setupView() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PostTableViewCell
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
