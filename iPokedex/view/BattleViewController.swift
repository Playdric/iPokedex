//
//  BattleViewController.swift
//  iPokedex
//
//  Created by Administrator on 24/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBOutlet weak var imageBlueTeamPokemon: UIImageView!
    
    @IBOutlet weak var imageRedTeamPokemon: UIImageView!
    
    @IBOutlet weak var pokemonBlueTeamName: UILabel!
    
    @IBOutlet weak var pokemonRedTeamName: UILabel!
    
    @IBOutlet weak var pokemonBlueTeamInfoSup: UILabel!
    
    @IBOutlet weak var pokemonRedTeamInfoSup: UILabel!
    
    @IBOutlet weak var imageBattle: UIImageView!

    var appDelegate: AppDelegate?
    
    var blueTeamPokemon: Pokemon?
    var redTeamPokemon: Pokemon?
    
    public static func newInstance() -> BattleViewController {
        var battleController = BattleViewController()
        return battleController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.blueTeamPokemon = appDelegate?.firstPokemon
        self.redTeamPokemon = appDelegate?.secondPokemon
        
        self.imageBlueTeamPokemon.image = blueTeamPokemon?.imagePokemon
        self.imageRedTeamPokemon.image = redTeamPokemon?.imagePokemon
        
        let tapRedGesture = UITapGestureRecognizer(target: self, action: #selector(imgTapped(imgTapGesture:)))
        let tapBlueGesture = UITapGestureRecognizer(target: self, action: #selector(imgTapped(imgTapGesture:)))
        let tapBattleGesture = UITapGestureRecognizer(target: self, action: #selector(battleTapped(imgTapGesture:)))
        
        imageRedTeamPokemon.isUserInteractionEnabled = true
        imageBlueTeamPokemon.isUserInteractionEnabled = true
        imageBattle.isUserInteractionEnabled = true
        
        imageRedTeamPokemon.addGestureRecognizer(tapRedGesture)
        imageBlueTeamPokemon.addGestureRecognizer(tapBlueGesture)
        imageBattle.addGestureRecognizer(tapBattleGesture)
        
        updateUI()
    }
    
    @objc func imgTapped(imgTapGesture: UITapGestureRecognizer){
        let tappedImage = imgTapGesture.view as! UIImageView
        resetImage(tag: tappedImage.tag)
        navigationController?.pushViewController(AllPokemonViewController(), animated: true)
    }
    
    @objc func battleTapped(imgTapGesture: UITapGestureRecognizer){
        if imageRedTeamPokemon.image != nil && imageBlueTeamPokemon.image != nil{
            navigationController?.pushViewController(battleSimulator(pokemon1: blueTeamPokemon!, pokemon2: redTeamPokemon!), animated: true)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "You should pick a Pokemon for each team", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI(){
        self.pokemonRedTeamName.text = self.redTeamPokemon?.getName()
        self.pokemonBlueTeamName.text = self.blueTeamPokemon?.getName()
    }
    
    func resetImage(tag: Int){
        if tag == 1 {
            appDelegate?.firstPokemon = nil
        }else{
            appDelegate?.secondPokemon = nil
        }
    }
    
    
    func battleSimulator(pokemon1: Pokemon, pokemon2: Pokemon) -> ResultViewController{
        var result = ResultViewController()
        
        //recuperation des data pour les comparer puisqu'elles sont nullables
        guard let hp1 = pokemon1.infoPokemon?.stats[5].base_stat, let hp2 = pokemon2.infoPokemon?.stats[5].base_stat,
            let attack1 = pokemon1.infoPokemon?.stats[4].base_stat, let attack2 = pokemon2.infoPokemon?.stats[4].base_stat,
            let defense1 = pokemon1.infoPokemon?.stats[3].base_stat, let defense2 = pokemon2.infoPokemon?.stats[3].base_stat,
            let speed1 = pokemon1.infoPokemon?.stats[0].base_stat, let speed2 = pokemon2.infoPokemon?.stats[0].base_stat else {
            let alert = UIAlertController(title: "Error retrieving data", message: "There was an issue getting the data of your pokemons", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return result
        }
        
        if hp1 > hp2 {
            result.score1 += 1
        }else{
            result.score2 += 1
        }
        
        if attack1 > attack2 {
            result.score1 += 1
        }else{
            result.score2 += 1
        }
        
        if defense1 > defense2 {
            result.score1 += 1
        }else{
            result.score2 += 1
        }
        
        if speed1 > speed2 * 2 {
            result.score1 += 1
        }else if speed2 > speed1 * 1 {
            result.score2 += 1
        }
        
        if result.score1 >= result.score2{
            result.winnerPokemon = pokemon1
        }else{
            result.winnerPokemon = pokemon2
        }
        
        return result
    }


}
