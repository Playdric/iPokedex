//
//  EvolutionModel.swift
//  iPokedex
//
//  Created by etudiant on 30/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import Foundation
import UIKit

class EvolutionModel : NSObject {
    
    public struct Evolution : Decodable{
        let chain: Chain
    }
    
    struct Chain : Decodable {
        let evolves_to: [EvolvesTo]?
        let evolution_details: [EvolutionDetails]?
        let species: Species?
    }
    
    struct EvolvesTo : Decodable {
        let species: Species
        let evolution_details:[EvolutionDetails]?
        let evolves_to: [EvolvesTo]?
    }
    
    struct EvolutionDetails : Decodable {
        let min_level: String?
    }
    
    struct Species : Decodable {
        let url: String?
        let name: String?
    }
    
    public struct SpeciesDetail : Decodable {
        let capture_rate: Int?
        let varieties: [Varieties]?
    }
    
    struct Varieties : Decodable {
        let is_default: Bool?
        let pokemon: Pokemon
    }
    
    struct Pokemon : Decodable{
        let name: String
        let url: String
    }
}
