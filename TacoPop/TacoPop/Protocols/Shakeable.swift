//
//  Shakeable.swift
//  TacoPop
//
//  Created by Захар on 03.02.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

protocol Shakeable {}

extension Shakeable where Self: UIView {
    func shake() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 0.05
        anim.repeatCount = 5
        anim.autoreverses = true
        anim.fromValue = -0.4
        anim.toValue = 0.4
        layer.add(anim, forKey: "transform.rotation")
    }
}
