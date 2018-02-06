//
//  EvolutionModel.swift
//  iPokedex
//
//  Created by Administrator on 06/02/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import Foundation

protocol EvolutionDelegate {
    func updateListPokemon(pokemon: Pokemon.EvoChain)
}

class EvolutionModel : NSObject{
    
    
    public func downloadPokemonEvolutionChain(jsonUrlString: String) {
        
        let url = URL(string: jsonUrlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard err == nil else {
                print("error calling the url. Please try with an existing url.")
                print(err!)
                return
            }
            
            guard let data = data else {
                print("Error in retrieving the data")
                return
            }
            
            do{
                let pokemonEvolutionChain = try JSONDecoder().decode(Pokemon.EvoChain.self, from: data)
                
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
                return
            }
            
        }
        
        task.resume()
    }
}
