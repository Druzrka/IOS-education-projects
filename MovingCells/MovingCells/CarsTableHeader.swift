//
//  CarsTableHeader.swift
//  MovingCells
//
//  Created by Захар on 25.01.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

class CarsTableHeader: UIView {
    
    @IBOutlet weak var carNameButton: UIButton!
    
    var section: Int!
    
    var nameButtonHandler: ((Int) -> Void)?
    var addButtonHandler: ((Int) -> Void)?
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addButtonHandler?(section)
    }
    
    @IBAction func namePressed(_ sender: UIButton) {
        nameButtonHandler?(section)
    }

}
