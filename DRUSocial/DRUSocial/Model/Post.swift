//
//  Post.swift
//  DRUsocial
//
//  Created by Захар on 01.06.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    var caption: String!
    var imageUrl: String!
    var likes: Int!
    var postKey: String!
    var postRef: DatabaseReference!
    
    init(caption: String, imageUrl: String, likes: Int, postKey: String) {
        self.caption = caption
        self.imageUrl = imageUrl
        self.likes = likes
        self.postKey = postKey
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self.postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self.caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self.likes = likes
        }
        
        postRef = DataService.shared.REF_POSTS.child(postKey)
    }
    
    public func adjustLikes(addLike: Bool) {
        if addLike {
            likes = likes + 1
        } else {
            likes = likes - 1
        }
        postRef.child("likes").setValue(likes)
    }
}
