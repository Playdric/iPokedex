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

    @IBOutlet weak var imageBattle: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    public var currentPokemon: Pokemon?
    private var task: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = self.currentPokemon?.getUrl()
        
        let url = URL(string: jsonUrlString!)
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
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
                
                DispatchQueue.main.async {
                    self.nameLabel.text = pokemonDetail.name.uppercased()
                    self.weightLabel.text = "Weight : \(pokemonDetail.weight) kg"
                    self.heightLabel.text = "Height : \(pokemonDetail.height)0 cm"
                    self.hpLabel.text = "HP : \(pokemonDetail.stats[5].base_stat)"
                    self.attackLabel.text = "Attack : \(pokemonDetail.stats[4].base_stat)"
                    self.defenseLabel.text = "Defense : \(pokemonDetail.stats[3].base_stat)"
                    self.baseSpeedLabel.text = "Speed : \(pokemonDetail.stats[0].base_stat)"
                    
                    self.currentPokemon?.downloadImage(urlString: pokemonDetail.sprites.front_default!, imageView: self.pokemonPicture)
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                }
                
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
                return
            }
            
        }
        
        task?.resume()
        
        let imgBattleGesture = UITapGestureRecognizer(target: self, action: #selector(imgBattleTapped(tapGesture:)))
        imageBattle.isUserInteractionEnabled = true
        imageBattle.addGestureRecognizer(imgBattleGesture)

    }
    
    @objc func imgBattleTapped(tapGesture: UITapGestureRecognizer){
        print("Tapped")
        //navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }

    
    func setCurrentPokemon(pokemon: Pokemon) {
        self.currentPokemon = pokemon
    }
    
}

