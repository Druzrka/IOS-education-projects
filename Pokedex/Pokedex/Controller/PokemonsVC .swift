//
//  ViewController.swift
//  Pokedex
//
//  Created by Захар on 27.11.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer: AVAudioPlayer!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        parsePokemonCSV()
        initAudio()
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    
    private func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: CSV PARSING
    
    private func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                pokemons.append(Pokemon(name: name, id: pokeId))
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "To Pokemon Details VC" {
            if let destination = segue.destination as? PokemonDetailsVC {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke
                }
            }
        }
    }
}

extension PokemonsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            
            if inSearchMode {
                
                cell.updateCell(pokemon: filteredPokemons[indexPath.row])
                
            } else {
                cell.updateCell(pokemon: pokemons[indexPath.row])
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode  {
            poke = filteredPokemons[indexPath.row]
            
        } else {
            poke = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "To Pokemon Details VC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemons.count
        }
        
        return pokemons.count
    }
}

extension PokemonsVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemons = pokemons.filter({ $0.name.range(of: lower) != nil })
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
}
