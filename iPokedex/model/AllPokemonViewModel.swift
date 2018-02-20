//
//  NetworkHandler.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 14/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

// Protocol to communicate with the ViewController
protocol AllPokemonsDelegate: class {
    func updateList(pokemons: [Pokemon])
    func networkIssue()
    func viewLoading()
    func fetchList(count: Int)
}

class AllPokemonViewModel: NSObject {
    
    weak var delegate: AllPokemonsDelegate?
    var task: URLSessionDataTask?
    
    public func getCount() {
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=0") else{
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
                    print("TASK CANCELED !")
                }
                return
            }
            
            guard let responseData = data else {
                print("error did not receive data from url")
                self.delegate?.networkIssue()
                return
            }
            do{
                let pokemonDetail = try JSONDecoder().decode(Pokemon.List.self, from: responseData)
                let pokemonCount = pokemonDetail.count
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.countPokemon = pokemonCount
                }
                self.delegate?.fetchList(count: pokemonCount)
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        self.task?.resume()
    }
    
    // In charge of requesting the API and getting the full list of pokemons.
    public func fetchAllPokemonList(count: Int) {
        let c = String(count)
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=" + c) else{
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
                    print("TASK CANCELED !")
                }
                return
            }
            
            guard let responseData = data else {
                print("error did not receive data from url")
                self.delegate?.networkIssue()
                return
            }
            do{
                let pokemonDetail = try JSONDecoder().decode(Pokemon.List.self, from: responseData)
                var pokemonList = [Pokemon]()
                for i in 0...pokemonDetail.results.count - 1 {
                    var name = pokemonDetail.results[i].name
                    let url = pokemonDetail.results[i].url
                    name = name.capitalized
                    let pokemon = Pokemon(name: name, url: url)
                    pokemonList.append(pokemon)
                }
                self.delegate?.updateList(pokemons: pokemonList)
            }catch{
                print("error trying to convert data to JSON")
                self.delegate?.networkIssue()
                return
            }
            
        }
        self.task?.resume()
    }
    
    
}
