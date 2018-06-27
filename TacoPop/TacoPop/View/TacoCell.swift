//
//  TacoCell.swift
//  TacoPop
//
//  Created by Захар on 02.02.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

class TacoCell: UICollectionViewCell, NibLoadableView, Shakeable {
    
    @IBOutlet weak var tacoImage: UIImageView!
    @IBOutlet weak var tacoLabel: UILabel!
    
    var taco: Taco!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(taco: Taco) {
        self.taco = taco
        tacoImage.image = UIImage(named: taco.proteinId.rawValue)
        tacoLabel.text = taco.productName
    }
}
