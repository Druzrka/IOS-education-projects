//
//  VideoVC.swift
//  PartyRock
//
//  Created by Захар on 24.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {
    
    private var _partyRock: PartyRock!
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var partyRock: PartyRock {
        get {
            return _partyRock
        } set {
            _partyRock = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTitle.text = partyRock.videoTitle
        webView.loadHTMLString(partyRock.videoURL, baseURL: nil)
    }
}
