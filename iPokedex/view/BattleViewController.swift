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
    
    public var blueTeamImage: UIImage?
    public var redTeamImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageBlueTeamPokemon.image = blueTeamImage
    }


}
