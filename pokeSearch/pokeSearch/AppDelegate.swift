//
//  AppDelegate.swift
//  pokeSearch
//
//  Created by Захар on 15.03.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

