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
    @IBOutlet weak var growRateLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var pokemonPicture: UIImageView!
    
    public var currentPokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = currentPokemon?.getName()
    }

    func setCurrentPokemon(pokemon: Pokemon) {
        self.currentPokemon = pokemon
    }

}
