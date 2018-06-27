//
//  PartyRock.swift
//  PartyRock
//
//  Created by Захар on 24.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import Foundation


class PartyRock {
    
    private var _imageURL: String!
    private var _videoURl: String!
    private var _videoTitle: String!
    
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURl
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    init(imageURL: String, videoURl: String, videoTitle: String) {
        _imageURL = imageURL
        _videoURl = videoURl
        _videoTitle = videoTitle
    }
}
