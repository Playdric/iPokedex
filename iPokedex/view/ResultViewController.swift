//
//  ResultViewController.swift
//  iPokedex
//
//  Created by Adama on 19/02/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var labelWinnerTeam: UILabel!
    @IBOutlet weak var imageWinnerPokemon: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var viewBackGround: UIView!
    
    var score1 = 0
    var score2 = 0
    var winnerPokemon: Pokemon?
    
    override func viewWillAppear(_ animated: Bool) {
        btnRetry.layer.cornerRadius = 5
        btnRetry.layer.borderWidth = 1
        btnRetry.layer.borderColor = UIColor.white.cgColor
        
        if score1 > score2 {
            //self.viewBackGround.backgroundColor = UIColor(red: 0, green: 166, blue: 255, alpha: 1)
            self.labelWinnerTeam.text = "Blue Team Wins"
        }else{
            //self.viewBackGround.backgroundColor = UIColor(red: 249, green: 95, blue: 98, alpha: 1.00)
            self.labelWinnerTeam.text = "Red Team Wins"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageWinnerPokemon.image = winnerPokemon?.imagePokemon
        labelScore.text = "Score : \(score1) - \(score2)"
        
        
    }

    @IBAction func touchRetry(_ sender: Any) {
        navigationController?.pushViewController(BattleViewController.newInstance(), animated: true)
    }
}
