//
//  SearchViewModel.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 21/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

// Protocol to communicate with the ViewController
protocol SearchDetailDelegate: class {
    func printResult(str: String)
}

class SearchViewModel: NSObject {
    
    weak var delegate: SearchDetailDelegate?
    var task: URLSessionDataTask?
    
    // In charge of requesting the API and getting the full list of pokemons.
    public func searchOnePokemon(pokemon: String?) {
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/" + pokemon!) else{
            print("error : cannot create URL")
            return
        }
        self.task = URLSession.shared.dataTask(with: url){ data, response, error in
            
            guard let responseData = data else {
                print("error did not receive data from url")
                return
            }
            do{
                guard let pokemon = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else{
                    print("error trying to convert data to JSON")
                    return
                }
                if pokemon["detail"] as? String == "Not found." {
                    print("not found loololololololololoolol")
                    self.delegate?.printResult(str: pokemon["detail"] as! String)
                    return
                }
//                let pokList = Pokemon.parseJSON(nsarray: nsarray)
                self.parseOnePokemon(dict: pokemon)
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        self.task?.resume()
    }
    
    private func parseOnePokemon(dict: [String: Any]) {
        self.delegate?.printResult(str: dict["location_area_encounters"] as! String)
        guard let abilitiesNSArray = dict["types"] as? NSArray else {
            print("error NSArray")
            return
        }
        var result = ""
        for i in 0...abilitiesNSArray.count - 1 {
            let nsdict = abilitiesNSArray[i] as! NSDictionary
            let type = nsdict["type"] as! NSDictionary
            let typeName = type["name"] as! String
            result += typeName
            if i != abilitiesNSArray.count - 1 {
                result += ", "
            }
        }
        self.delegate?.printResult(str: result)
        
    }
}

