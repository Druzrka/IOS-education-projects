//
//  DetailCell.swift
//  Pokedex
//
//  Created by Захар on 01.12.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    
    
    func updateDetail(detail: String, detailName: String) {
        
        detailLabel.text = detail
        detailNameLabel.text = detailName + ":"
        
        detailLabel.adjustsFontSizeToFitWidth = true
        detailNameLabel.adjustsFontSizeToFitWidth = true
    }
}
