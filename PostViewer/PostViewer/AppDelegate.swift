//
//  AppDelegate.swift
//  PostViewer
//
//  Created by Nazariy Vlizlo on 12/22/18.
//  Copyright © 2018 Nazariy Vlizlo. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
}

