//
//  Pokemon.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import Foundation

class Pokemon: NSObject {
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
