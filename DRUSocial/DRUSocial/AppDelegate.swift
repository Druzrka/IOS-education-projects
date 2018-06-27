//
//  AppDelegate.swift
//  DRUsocial
//
//  Created by Захар on 22.03.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

func handleError<T>(_ error: T) {
    if error is NSError || error is Error {
        print("LOG ERROR HANDLED: ", error)
    }
}

