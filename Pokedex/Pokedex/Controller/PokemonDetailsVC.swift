//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Захар on 29.11.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var desriptionLabel: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    var pokemon: Pokemon!
    
    var detailNames = ["Type", "Defense", "Height", "Pokedex ID", "Weight", "Base Attack"]
    var details: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setPokemonName()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlSwitched(_ sender: UISegmentedControl) {
        
    }
}

extension PokemonDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        cell.updateDetail(detail: "", detailName: detailNames[indexPath.row])
        
        return cell
    }
}

// MARK: UI METHODS
extension PokemonDetailsVC {
    
    func setPokemonName() {
        nameLabel.text = pokemon.name
    }
}
