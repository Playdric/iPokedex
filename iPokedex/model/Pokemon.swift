//
//  Pokemon.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import Foundation
import UIKit


public class Pokemon: NSObject {
    private var name: String
    private var url: String
    public var infoPokemon: Detail?
    var imagePokemon: UIImage?
    
    init(name: String,url: String) {
        self.name = name
        self.url = url
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getUrl() -> String {
        return self.url
    }
    
    

    
    //structs added to match the needed proprieties from the json
    public struct Detail : Decodable {
        let id: Int
        let name: String
        let weight: Int
        let height: Int
        let stats: [Stats]
        let sprites: Sprites
        let types: [Types]
        let species: UrlName
    }
    
    struct Stats : Decodable {
        let stat: UrlName?
        let effort: Int
        let base_stat: Int
        
    }
    
    
    struct Sprites : Decodable { //url of the images (shiney, female, front, back...)
        let front_default: String?
        let back_default: String?
    }
    
    struct Types : Decodable {
        let slot: Int?
        let type: UrlName?
    }
    
    struct UrlName : Decodable {
        let url: String?
        let name: String?
    }

    public struct Evolution : Decodable{
        let chain: Chain
    }
    
    struct Chain : Decodable {
        let evolves_to: [EvolvesTo]?
        let evolution_details: [EvolutionDetails]?
        let species: UrlName?
    }
    
    struct EvolvesTo : Decodable {
        let species: UrlName?
        let evolution_details:[EvolutionDetails]?
        let evolves_to: [EvolvesTo]?
    }
    
    struct EvolutionDetails : Decodable {
        let min_level: String?
    }
    
    public struct SpeciesDetail : Decodable {
        let capture_rate: Int?
        let varieties: [Varieties]?
    }
    
    struct Varieties : Decodable {
        let is_default: Bool?
        let pokemon: UrlName?
    }
    
    
    
    // Struct for the list of pokemons
    struct List: Decodable {
        let count: Int
        let results: [Results]
    }
    
    struct Results: Decodable {
        let name: String
        let url: String
    }
    
}
