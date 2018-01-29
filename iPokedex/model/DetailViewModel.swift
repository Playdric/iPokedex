//
//  DetailViewModel.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 28/01/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

// Protocol to communicate with the ViewController
protocol DetailDelegate: class {
    func updateUI(pokemonDetail: Pokemon.Detail)
    func updateImageView(image: UIImage)
}

class DetailViewModel: NSObject {
    
    weak var delegate: DetailDelegate?
    
    public func downloadPokemonInfos(jsonUrlString: String) {
        
        let url = URL(string: jsonUrlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard err == nil else {
                print("error calling the url. Please try with an existing url.")
                print(err!)
            return
            }
            
            guard let data = data else {
                print("Error in retrieving the data")
                return
            }
            
            do{
                let pokemonDetail = try JSONDecoder().decode(Pokemon.Detail.self, from: data)
                self.downloadImage(urlString: pokemonDetail.sprites.front_default!)
                self.delegate?.updateUI(pokemonDetail: pokemonDetail)
                
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
                return
            }
            
        }
        
        task.resume()
    }
    
    func downloadImage(urlString: String){
        
        let url:URL = URL(string: urlString)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, err) in
            if data != nil{
                let image = UIImage(data: data!)
                if image != nil{
                    self.delegate?.updateImageView(image: image!)
                }
            }else{
                print("erreur dans la récupération de l'image")
            }
        }
        task.resume()
    }
}
