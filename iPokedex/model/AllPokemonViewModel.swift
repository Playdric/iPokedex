//
//  NetworkHandler.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 14/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

// Protocol to communicate with the ViewController
protocol AllPokemonDetailDelegate: class {
    func updateList(pokemons: [Pokemon])
    func networkIssue()
    func viewLoading()
}

class AllPokemonViewModel: NSObject {
    
    weak var delegate: AllPokemonDetailDelegate?
    var task: URLSessionDataTask?
    
    // In charge of requesting the API and getting the full list of pokemons.
    public func fetchAllPokemonList() {
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=949") else{
            print("error : cannot create URL")
            return
        }
        self.task = URLSession.shared.dataTask(with: url){ data, response, error in
            self.delegate?.viewLoading()
            
            // Error managment
            // Looks like it's useless but if I remove it, the ViewController display
            // the "network issue" message when the user clicks on the refresh button
            // while the task is still running.
            if let error = error as NSError? {
                if error.code == NSURLErrorCancelled {
                    print("TASK CANCELED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                }
                return
            }
            
            guard let responseData = data else {
                print("error did not receive data from url")
                self.delegate?.networkIssue()
                return
            }
            do{
                guard let pokemon = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else{
                    print("error trying to convert data to JSON")
                    self.delegate?.networkIssue()
                    return
                }
                guard let nsarray = pokemon["results"] as? NSArray else {
                    print("error NSArray")
                    return
                }
                
                let pokList = Pokemon.parseJSON(nsarray: nsarray)
                self.delegate?.updateList(pokemons: pokList)
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        self.task?.resume()
    }
    
    
}
