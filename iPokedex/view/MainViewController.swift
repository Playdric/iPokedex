//
//  MainViewController.swift
//  iPokedex
//
//  Created by Cedric on 24/12/2017.
//  Copyright © 2017 Cedric. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var pokedexImageView: UIImageView!
    @IBOutlet weak var battleImageView: UIImageView!
    
    var pokemonList = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iPokedex"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "About us", style: .plain, target: self, action: #selector(touchAboutButton))
        
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
                self.pokemonList = Pokemon.parseJSON(nsarray: nsarray)
            }catch{
                print("error trying to convert data to JSON")
                return
            }
            
        }
        print("Before task.resume()")
        task.resume()
        print("After task.resume()")
        
    }
  
    @IBAction func btnAllPokemonList(_ sender: Any) {
        let nextController = AllPokemonViewController()
        nextController.pokemons = self.pokemonList
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    @IBAction func touchAboutButton() {
        self.navigationController?.pushViewController(AboutViewController(), animated: true)
    }

}
