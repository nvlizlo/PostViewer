//
//  FirebaseService.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 2/4/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    let ref = Database.database().reference(withPath: "posts")
}
