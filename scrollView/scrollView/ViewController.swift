//
//  ViewController.swift
//  scrollView
//
//  Created by Захар on 06.08.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0
        let scrollViewWidth = scrollView.frame.size.width
        scrollView.clipsToBounds = false
        
        for index in 0...2 {
            let image = UIImage(named: "icon\(index).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            
            newX = scrollViewWidth / 2 + scrollViewWidth * CGFloat(index)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        }
        scrollView.contentSize.width = contentWidth
    }
}

