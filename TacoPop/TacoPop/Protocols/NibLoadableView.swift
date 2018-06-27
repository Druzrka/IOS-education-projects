//
//  NibLoadableView.swift
//  TacoPop
//
//  Created by Захар on 02.02.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
