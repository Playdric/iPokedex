//
//  DetailViewController.swift
//  iPokedex
//
//  Created by Administrator on 02/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit


struct Detail : Decodable {
    let name: String
    let weight: Int
    let stats: [Stats]
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

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var baseSPLabel: UILabel!
    @IBOutlet weak var baseSpeedLabel: UILabel!
    @IBOutlet weak var growRateLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    public var currentPokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = currentPokemon?.getName()
        
        
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
                let pokemonDetail = try JSONDecoder().decode(Detail.self, from: data)
                print(pokemonDetail)
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
            }
            
            
        }.resume()
    }

    func setCurrentPokemon(pokemon: Pokemon) {
        self.currentPokemon = pokemon
    }

}
