//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Захар on 27.11.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
    }
    
    func updateCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = pokemon.name.capitalized
        thumbImage.image = UIImage(named: String(pokemon.pokedexId))
    }
}
