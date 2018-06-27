//
//  Pokemon.swift
//  Pokedex
//
//  Created by Захар on 27.11.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _desription: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, id: Int) {
        _name = name
        _pokedexId = id
        _pokemonURL = BASE_URL + POKEMON_URL + String(_pokedexId) + "/"
    }
}
