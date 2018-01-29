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
        let name: String
        let weight: Int
        let height: Int
        let stats: [Stats]
        let sprites: Sprites
        let types: [Types]
    }
    
    struct Stats : Decodable {
        let stat: Stat?
        let effort: Int
        let base_stat: Int
        
    }
    
    struct Stat : Decodable {
        let url: String
        let name: String
    }
    
    struct Sprites : Decodable { //url of the images (shiney, female, front, back...)
        let front_default: String?
        let back_default: String?
    }
    
    struct Types : Decodable {
        let slot: Int
        let type: _Type
    }
    
    struct _Type : Decodable {
        let url: String
        let name: String
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
