//
//  DetailViewController.swift
//  iPokedex
//
//  Created by Administrator on 02/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var baseSPLabel: UILabel!
    @IBOutlet weak var baseSpeedLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    public var currentPokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = self.currentPokemon?.getUrl()
        
        
        let url = URL(string: jsonUrlString!)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
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
                let pokemonDetail = try JSONDecoder().decode(Pokemon.Detail.self, from: data)
                print(pokemonDetail)
                //do delegates
                
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
                return
            }
            

        }.resume()
        

    }

    func setCurrentPokemon(pokemon: Pokemon) {
        self.currentPokemon = pokemon
    }
    
}
