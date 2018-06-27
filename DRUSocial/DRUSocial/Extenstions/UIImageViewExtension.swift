//
//  UIImageViewExtension.swift
//  DRUsocial
//
//  Created by Захар on 31.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

// Circular image extension
extension UIImageView {
    
    open func circularImage() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
