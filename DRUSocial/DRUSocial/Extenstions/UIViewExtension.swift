//
//  UIViewExtension.swift
//  DRUsocial
//
//  Created by Захар on 31.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

extension UIView {
    
    var defaultCornerRadius: CGFloat { return 3.0 }
    
    open func setupDefaultShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
