//
//  Pokemon.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import Foundation

public class Pokemon: NSObject {
    private var name: String
    private var url: String
    
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
    struct Detail : Decodable {
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

    
    public static func parseJSON(nsarray: NSArray) -> [Pokemon] {
        var pokemonList = [Pokemon]()
        for i in 0...nsarray.count-1 {
            let nsdict = nsarray[i] as! NSDictionary
            var name = nsdict["name"] as! String
            let url = nsdict["url"] as! String
            name = name.capitalized
            let pokemon = Pokemon(name: name, url: url)
            pokemonList.append(pokemon)
        }
        return pokemonList
    }
    
}
