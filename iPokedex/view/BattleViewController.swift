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
        
        imageRedTeamPokemon.isUserInteractionEnabled = true
        imageBlueTeamPokemon.isUserInteractionEnabled = true
        
        imageRedTeamPokemon.addGestureRecognizer(tapRedGesture)
        imageBlueTeamPokemon.addGestureRecognizer(tapBlueGesture)
        
        updateUI()
    }
    
    @objc func imgTapped(imgTapGesture: UITapGestureRecognizer){
        let tappedImage = imgTapGesture.view as! UIImageView
        resetImage(tag: tappedImage.tag)
        navigationController?.pushViewController(AllPokemonViewController(), animated: true)
        
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


}
