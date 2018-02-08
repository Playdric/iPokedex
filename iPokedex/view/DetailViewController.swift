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
    
    @IBOutlet weak var imagePrevious: UIImageView!
    @IBOutlet weak var imageNext: UIImageView!
    
    @IBOutlet weak var imageBattle: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    var appDelegate: AppDelegate?
    public var currentPokemon: Pokemon?
    private var task: URLSessionTask?
    
    private var baseString: String = "https://pokeapi.co/api/v2/pokemon/"
    
    private let dataModel = DetailViewModel()
    
    var idPokemon: Int?
    
    var jsonUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData(givenUrl: (self.currentPokemon?.getUrl())!)
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
    
    private func loadData(givenUrl: String){
        //TODO mettre la fonction ici
        self.dataModel.delegate = self
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        let imgBattleGesture = UITapGestureRecognizer(target: self, action: #selector(imgBattleTapped(tapGesture:)))
        imageBattle.isUserInteractionEnabled = true
        imageBattle.addGestureRecognizer(imgBattleGesture)
        
        
        jsonUrlString = givenUrl
        
        self.dataModel.downloadPokemonInfos(jsonUrlString: jsonUrlString!)
        
        let imgPreviousGesture = UITapGestureRecognizer(target: self, action: #selector(getPreviousPokemon))
        imagePrevious.isUserInteractionEnabled = false
        imagePrevious.addGestureRecognizer(imgPreviousGesture)
        imagePrevious.isHidden = true
        
        let imgNextGesture = UITapGestureRecognizer(target: self, action: #selector(getNextPokemon))
        imageNext.isUserInteractionEnabled = false
        imageNext.addGestureRecognizer(imgNextGesture)
        imageNext.isHidden = true
    }

    
    @objc func getNextPokemon(){
        guard var idIncr = self.idPokemon else {
            return
        }
        idIncr += 1
        if idIncr >= (appDelegate?.countPokemon)!{
            return
            //popup erreur
        }
        pokemonPicture.image = nil
        let str = "\(baseString)\(idIncr)/"
        loadData(givenUrl: str)
    }
    
    @objc func getPreviousPokemon(){
        guard var idDecr = self.idPokemon else {
            return
        }
        idDecr -= 1
        if idDecr <= 0 {
            return
            //popup erreur
        }
        pokemonPicture.image = nil
        let str = "\(baseString)\(idDecr)/"
        loadData(givenUrl: str)
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
            self.typeLabel.text = "Type : \(self.getAllTypes(pokemon: pokemonDetail))" //plusieurs types peuvent être sur un pokemon
            self.idPokemon = pokemonDetail.id
            
            self.imagePrevious.isHidden = false
            self.imageNext.isHidden = false
            self.imagePrevious.isUserInteractionEnabled = true
            self.imageNext.isUserInteractionEnabled = true
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func getAllTypes(pokemon: Pokemon.Detail) -> String {
        var res: String = ""
        var cpt: Int = 0
        for val in pokemon.types {
            cpt += 1
            res += "\((val.type?.name) ?? "No types") "
            if cpt < pokemon.types.count {
                res += "| "
            }
        }
        
        return res
    }
}
