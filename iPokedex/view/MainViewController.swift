//
//  MainViewController.swift
//  iPokedex
//
//  Created by Cedric on 24/12/2017.
//  Copyright © 2017 Cedric. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var pokedexImageView: UIImageView!
    @IBOutlet weak var battleImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iPokedex"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "About us", style: .plain, target: self, action: #selector(touchAboutButton))
        
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @IBAction func btnAllPokemonList(_ sender: Any) {
        self.navigationController?.pushViewController(AllPokemonViewController(), animated: true)
    }
    
    @IBAction func touchAboutButton() {
        self.navigationController?.pushViewController(AboutViewController(), animated: true)
    }

}
