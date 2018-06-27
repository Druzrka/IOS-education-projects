//
//  DataService.swift
//  DRUsocial
//
//  Created by Захар on 31.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

fileprivate let DB_BASE = Database.database().reference()
fileprivate let STORAGE_BASE = Storage.storage().reference()

final class DataService {
    
    static let shared = DataService()
    
    // DB reference
    private var _REF_BASE  = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    public var REF_CURRENT_USER: DatabaseReference! {
        if let uid = KeychainWrapper.standard.string(forKey: KeychainKeys.uid.rawValue) {
            return REF_USERS.child(uid)
        }
        print("Error: can't find id of user")
        return DatabaseReference()
    }
    
    // Storage reference
    public var REF_POST_PICTURES = STORAGE_BASE.child("postPictures")
    
    public var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    public var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    public var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    public func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
