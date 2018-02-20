//
//  AsyncImageView.swift
//  iPokedex
//
//  Created by Cédric NANTEAU Dev on 02/02/2018.
//  Copyright © 2018 Cedric. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView {

    private var dlTask: URLSessionDataTask?
    private var task: URLSessionDataTask?
    
    
    public func loadImageWithPokemonName(str: String) {
        self.dlTask?.cancel()
        self.task?.cancel()
        let strUrl = "https://pokeapi.co/api/v2/pokemon/" + str
        guard let url = URL(string: strUrl) else {
            return
        }
        self.task = URLSession.shared.dataTask(with: url) { (data, response, err) in
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
                let urlSprite = pokemonDetail.sprites.front_default
                if urlSprite != nil {
                    let url = URL(string: urlSprite!)
                    self.loadImage(url: url!)
                }
                
            }catch let jsonErr {
                print("Error in serializing the json :", jsonErr)
                return
            }
            
        }
        
        self.task?.resume()
    }
    
    
    
    public func loadImage(url: URL) {
        self.dlTask?.cancel()
        self.dlTask = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let error = err as NSError? {
                if error.code == NSURLErrorCancelled {
                    print("TASK CANCELED !")
                }
                return
            }
            guard
                let receivedData = data,
                let receivedImage = UIImage(data: receivedData) else {
                        print("errorImage")
                    return
            }
            DispatchQueue.main.async {
                self.image = receivedImage
            }
        }
        self.dlTask?.resume()
    }

}
