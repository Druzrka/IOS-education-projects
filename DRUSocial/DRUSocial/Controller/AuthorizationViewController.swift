//
//  AuthorizationViewController.swift
//  DRUsocial
//
//  Created by Захар on 26.03.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

enum KeychainKeys: String {
    case isLogined = "user is logined"
    case uid       = "UID"
}

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUserIsLogined()
    }
    
    //MARK: Methods
    private func firebaseAuth(with credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Unable to authenticate user by firebase - " + error.debugDescription)
                
            } else if let userId = user?.uid {
                let userData = ["provider": credential.provider]
                self.handleLoginResponse(userId: userId, userData: userData)
                print("Successfully authenticated with Firebase")
            }
        }
    }
    
    private func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate user by firebase - " + error.debugDescription)
                
            } else if let userId = user?.uid {
                let userData = ["provider": "email"]
                self.handleLoginResponse(userId: userId, userData: userData)
                print("User was successfully created with Firebase by email")
            }
        })
    }
    
    private func logIn() {
        
        guard let email = emailTextField.text, let pwd = passwordTextField.text, email.isEmpty == false && pwd.isEmpty == false else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
            if error != nil {
                
                let noUserInBaseErrorCode = 17011
                if let err = error as NSError?, err.code == noUserInBaseErrorCode {
                    self.createUser(email: email, password: pwd)
                    
                } else {
                    print("Unable to authenticate user by firebase - " + error.debugDescription)
                }
                
            } else if let userId = user?.uid, let providerId = user?.providerID {
                let userData = ["provider": providerId]
                self.handleLoginResponse(userId: userId, userData: userData)
                print("Successfully sign in with Firebase by email")
            }
        }
    }
    
    private func setUserLogined(userId: String) {
        KeychainWrapper.standard.set(true, forKey: KeychainKeys.isLogined.rawValue)
        KeychainWrapper.standard.set(userId, forKey: KeychainKeys.uid.rawValue)
    }
    
    private func checkUserIsLogined() {
        if isLogined() {
            showFeed()
        }
    }
    
    private func handleLoginResponse(userId: String, userData: Dictionary<String, String>) {
        DataService.shared.createFirebaseDBUser(uid: userId, userData: userData)
        self.setUserLogined(userId: userId)
        self.showFeed()
    }
    
    private func isLogined() -> Bool {
        
        if let isLogined = KeychainWrapper.standard.bool(forKey: KeychainKeys.isLogined.rawValue), isLogined {
            return isLogined
        }
        
        return false
    }
    
    private func showFeed() {
        performSegue(withIdentifier: "showFeedViewController", sender: nil)
    }
    
    // MARK: IBActions
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authenticate user by facebook - " + error.debugDescription)
                
            } else if result?.isCancelled == true {
                print("User cancelled facebook authentication")
                
            } else {
                print("Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(with: credential)
            }
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
       logIn()
    }
    
}
