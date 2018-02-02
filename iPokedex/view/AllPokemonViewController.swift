//
//  AllPokemonViewController.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 06/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class AllPokemonViewController: UIViewController {
    

    @IBOutlet weak var networkIssueLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var searchActive : Bool = false
    private var refreshControl: UIRefreshControl!
    private var pokemons: [Pokemon] = []
    private var filteredPokemons = [Pokemon]()
    private let dataModel = AllPokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All pokemons"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTouchRefresh))
        viewIsLoading()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.dataModel.delegate = self
        self.dataModel.getCount()
        self.tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
    }
    
    // Managing UI elements, the view should be in loading mode
    func viewIsLoading() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.networkIssueLabel.isHidden = true
        self.tableView.isHidden = true
    }
    
    // Managing UI elements, the view should be displaying the list of pokemons
    func viewIsDisplayingList() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.networkIssueLabel.isHidden = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
        // Re init the search bar and hide keyboard
        self.searchBar.text = ""
        self.view.endEditing(true)
    }
    
    // Managing UI elements, the view should be in network issue mode
    func viewIsNetworkIssue() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.networkIssueLabel.isHidden = false
        self.tableView.isHidden = true
    }
    
    // When the user click the refrech button
    @objc func didTouchRefresh() {
        // Cancel the current task
        self.dataModel.task?.cancel()
        self.viewIsLoading()
        // Re launch the task
        self.dataModel.getCount()
        // Hide keyboard
        self.view.endEditing(true)
    }
    
}


extension AllPokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPokemons.count == 0 {
            return self.pokemons.count
        } else {
            return self.filteredPokemons.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var idx = self.pokemons.index(self.pokemons.startIndex, offsetBy: indexPath.row)
        var pokemonName: String
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.pokemonImgView.image = UIImage(named: "sad-pika.png")
            if(self.searchActive){
                idx = self.filteredPokemons.index(self.filteredPokemons.startIndex, offsetBy: indexPath.row)
                if self.filteredPokemons.count == 0 {
                    pokemonName = ""
                } else {
                    pokemonName = self.filteredPokemons[idx].getName()
                }
            } else {
                pokemonName = self.pokemons[idx].getName()
            }
            pokemonCell.pokemonNameLabel.text = pokemonName
            //TODO same pour l'image
            pokemonName = pokemonName.lowercased()
            pokemonCell.pokemonImgView.loadImageWithPokemonName(str: pokemonName)
        }
        return cell
    }
}

extension AllPokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pokemon: Pokemon
        if(self.searchActive){
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        let viewController = DetailViewController()
        viewController.setCurrentPokemon(pokemon: pokemon)
        print(pokemon.getName())
        navigationController?.pushViewController(viewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// Implementing protocol methods
extension AllPokemonViewController: AllPokemonsDelegate {
    
    
    // updating the local variable of pôkemons list
    func updateList(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        //The following code will be executed in the main thread
        DispatchQueue.main.async {
            self.viewIsDisplayingList()
        }
    }
    
    func networkIssue() {
        // The following code will be executed in the main thread
        DispatchQueue.main.async {
            self.viewIsNetworkIssue()
        }
    }
    
    func viewLoading() {
        // The following code will be executed in the main thread
        DispatchQueue.main.async {
            self.viewIsLoading()
        }
    }
    
    func fetchList(count: Int) {
        DispatchQueue.main.async {
            self.dataModel.fetchAllPokemonList(count: count)
        }
    }
}

extension AllPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBar.text! == "" {
            self.filteredPokemons = self.pokemons
            self.searchActive = false
        } else {
            self.filteredPokemons = self.pokemons.filter { $0.getName().lowercased().contains(self.searchBar.text!.lowercased()) }
            self.searchActive = true
        }
    
        self.tableView.reloadData()
    }
}
