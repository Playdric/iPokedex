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
    public var pokemons: [Pokemon] = []
    private let dataModel = AllPokemonViewModel()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All pokemons"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTouchRefresh))
        viewIsLoading()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.dataModel.delegate = self
        self.dataModel.getCount()
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
    }
}


extension AllPokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = self.pokemons.index(self.pokemons.startIndex, offsetBy: indexPath.row)
        let c = self.pokemons[idx].getName()
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") ?? UITableViewCell(style: .default, reuseIdentifier: "nameCell")
        cell.textLabel?.text = c
        return cell
    }

}

extension AllPokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        let viewController = DetailViewController()
        viewController.setCurrentPokemon(pokemon: pokemon)
        print(pokemon.getName())
        navigationController?.pushViewController(viewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
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
