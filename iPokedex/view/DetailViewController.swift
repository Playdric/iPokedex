//
//  DetailViewController.swift
//  iPokedex
//
//  Created by Administrator on 02/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var baseSPLabel: UILabel!
    @IBOutlet weak var baseSpeedLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var imageBattle: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    var appDelegate: AppDelegate?
    public var currentPokemon: Pokemon?
    private var task: URLSessionTask?
    
    private let dataModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let jsonUrlString = self.currentPokemon?.getUrl()
        //TODO mettre la fonction ici
        self.dataModel.delegate = self
        self.dataModel.downloadPokemonInfos(jsonUrlString: jsonUrlString!)
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        let imgBattleGesture = UITapGestureRecognizer(target: self, action: #selector(imgBattleTapped(tapGesture:)))
        imageBattle.isUserInteractionEnabled = true
        imageBattle.addGestureRecognizer(imgBattleGesture)

    }
    
    @objc func imgBattleTapped(tapGesture: UITapGestureRecognizer){
        navigationController?.pushViewController(BattleViewController.newInstance(), animated: true)
        
        self.currentPokemon?.imagePokemon = self.pokemonPicture.image //Stock de l'image dans l'objet Pokemon pour eviter un autre appel plus tard
        if self.appDelegate?.firstPokemon != nil{
            self.appDelegate?.secondPokemon = self.currentPokemon
        }else{
            self.appDelegate?.firstPokemon = self.currentPokemon
        }
    }

    
    func setCurrentPokemon(pokemon: Pokemon) {
        self.currentPokemon = pokemon
    }
    
}

extension DetailViewController: DetailDelegate {
    func updateImageView(image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonPicture.contentMode = UIViewContentMode.scaleAspectFit
            self.pokemonPicture.image = image
        }
    }
    
    
    func updateUI(pokemonDetail: Pokemon.Detail) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemonDetail.name.uppercased()
            self.weightLabel.text = "Weight : \(pokemonDetail.weight) kg"
            self.heightLabel.text = "Height : \(pokemonDetail.height)0 cm"
            self.hpLabel.text = "HP : \(pokemonDetail.stats[5].base_stat)"
            self.attackLabel.text = "Attack : \(pokemonDetail.stats[4].base_stat)"
            self.defenseLabel.text = "Defense : \(pokemonDetail.stats[3].base_stat)"
            self.baseSpeedLabel.text = "Speed : \(pokemonDetail.stats[0].base_stat)"
            self.typeLabel.text = "Type : \(pokemonDetail.types[0].type.name)"
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

extension DetailViewController : EvolutionDelegate {
    func updateListPokemon(pokemon: Pokemon.EvoChain) {
        //
    }
    
    
}

