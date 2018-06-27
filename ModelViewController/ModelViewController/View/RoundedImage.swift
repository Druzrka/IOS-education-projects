//
//  RoundedImage.swift
//  ModelViewController
//
//  Created by Захар on 24.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 6
    }
}
