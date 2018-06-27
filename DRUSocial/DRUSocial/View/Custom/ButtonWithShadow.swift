//
//  ButtonWithShadow.swift
//  DRUsocial
//
//  Created by Захар on 31.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

class ButtonWithShadow: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupDefaultShadow()
        layer.cornerRadius = defaultCornerRadius
    }
}
