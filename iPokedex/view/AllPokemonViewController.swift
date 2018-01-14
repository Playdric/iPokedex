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
        self.title = "Tous les pokemons"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "nimportequoi") ?? UITableViewCell(style: .default, reuseIdentifier: "nimportequoi")
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
        //Url de l'API
        let endpoint : String = "http://pokeapi.co/api/v2/pokemon/?limit=949"
        
        //test de la validité de l'url
        guard let url = URL(string: endpoint) else{
            print("error : cannot create URL")
            return
        }
        
        
        //Pour envoyer une request il nous faut une session (doc à lire sur Shared mais c'est par défaut)
        let session = URLSession.shared
        
        //Création de la task avec comme param l'url et la gestion du retour (completionHandler)
        let task = session.dataTask(with: url){ data, response, error in
            
            
            //test sur l'existence d'une erreur
            guard error == nil else{
                print("error calling the url")
                return
            }
            
            
            //test sur l'existence des données
            guard let responseData = data else {
                print("error did not receive data from url")
                return
            }
            
            do{
                //Parsing de la réponse en JSON parce que c'est ce que l'API nous renvoie
                guard let pokemon = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else{
                    print("error trying to convert data to JSON")
                    return
                }
                
                // Si on arrive ici alors on a le resultat de l'API
                // print("Le pokemon est: "+pokemon.description)
                //print(pokemon["results"])
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
                print("Pokemons loaded")
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        
        task.resume()
    }   
}
