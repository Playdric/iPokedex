//
//  AllPokemonViewController.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class AllPokemonViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.title = "All pokemons"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.isHidden = true
        fetchAllPokemonList()
    }

}


extension AllPokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = self.pokemons.index(self.pokemons.startIndex, offsetBy: indexPath.row)
        let c = self.pokemons[idx].getName()
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") ?? UITableViewCell(style: .default, reuseIdentifier: "nameCell")
        cell.textLabel?.text = c
        return cell
    }
    
}

extension AllPokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextController =
//        nextController.
//        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    public func fetchAllPokemonList() {
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?limit=949") else{
            print("error : cannot create URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let responseData = data else {
                print("error did not receive data from url")
                return
            }
            do{
                guard let pokemon = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else{
                    print("error trying to convert data to JSON")
                    return
                }
                guard let nsarray = pokemon["results"] as? NSArray else {
                    print("error NSArray")
                    return
                }
                self.pokemons = Pokemon.parseJSON(nsarray: nsarray)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.activityIndicator.isHidden = true
                }
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        
        task.resume()
    }   
}
