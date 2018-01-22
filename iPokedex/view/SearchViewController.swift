//
//  SearchViewController.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 20/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    private let dataModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.dataModel.delegate = self
    }
    @IBAction func didTouchPokemon(_ sender: Any) {
        dataModel.searchOnePokemon(pokemon: pokemonTextField.text)
    }
}

extension SearchViewController: SearchDetailDelegate {
    func printResult(str: String) {
        DispatchQueue.main.async {
            self.resultLabel.text = "Result: " + str
        }
        
    }
}
