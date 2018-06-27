//
//  MaterialView.swift
//  DreamLister
//
//  Created by Захар on 21.12.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {

    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        } set {
            materialKey = newValue
            
            if materialKey {
                layer.masksToBounds = false
                layer.cornerRadius = 3
                layer.shadowOpacity = 0.8
                layer.shadowRadius = 3
                layer.shadowOffset = CGSize(width: 0, height: 2)
                layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
            } else {
                layer.cornerRadius = 0
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowColor = nil
            }
        }
    }
}
