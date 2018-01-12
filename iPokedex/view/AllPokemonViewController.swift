//
//  AllPokemonViewController.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class AllPokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        for index in 1...100 {
            pokemons.append(Pokemon(name:"Pikachu\(index)", url:"url"))
        }
    }

}


extension AllPokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = self.pokemons.index(self.pokemons.startIndex, offsetBy: indexPath.row)
        let c = self.pokemons[idx].getName()
        let cell = tableView.dequeueReusableCell(withIdentifier: "nimportequoi") ?? UITableViewCell(style: .default, reuseIdentifier: "nimportequoi")
        cell.textLabel?.text = c
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("ok")
        let alert = UIAlertController(title: "Annention", message: "\(self.pokemons[indexPath.row].getName())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension AllPokemonViewController: UITableViewDelegate {
    
}
