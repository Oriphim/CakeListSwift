//
//  CakeListViewModel.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import Foundation
import UIKit

class CakeListViewModel {
    var cakes = [Cake]()
    let imageCache = NSCache<NSString, UIImage>()
    let cakeLoader = CakeLoader()
    fileprivate var dataURL = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    
    init() {
        imageCache.countLimit = 30
    }
    
    func countOfCakes() -> Int {
        return cakes.count
    }
    
    func cakeAtIndex(index: Int) -> Cake {
        return cakes[index]
    }
    
    func cakeImageCache(cake :Cake) -> UIImage? {
        return imageCache.object(forKey: cake.imageURL as NSString)
    }
    
    func cacheCakeImage(image: UIImage, cake: Cake) {
        imageCache.setObject(image, forKey: cake.imageURL as NSString)
    }
    
    func downloadCakeData(completionHandler :@escaping () -> (), errorHandler :@escaping(String) -> ()) {
        cakeLoader.downloadDataWithURL(urlString: dataURL) { [weak self] (result) in
            let errorMessage = "Error downloading Cake"
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    self?.cakes = try decoder.decode([Cake].self, from: data)
                    completionHandler()
                } catch {
                    errorHandler(errorMessage)
                }
                
            case .failure:
                errorHandler(errorMessage)
            }
        }
    }
    
    func imageDataForCake(cake :Cake,
                          completionHandler :@escaping (UIImage) -> ()) {
        if let cellImage = self.cakeImageCache(cake: cake) {
            completionHandler(cellImage)
        }
        else {
            cakeLoader.downloadImageWithURL(urlString: cake.imageURL) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.cacheCakeImage(image: image, cake: cake)
                    completionHandler(image)
                    
                case .failure:
                    let imageNotfound = #imageLiteral(resourceName: "imageNotFound")
                    self?.cacheCakeImage(image: imageNotfound, cake: cake)
                    completionHandler(imageNotfound)
                }
            }
        }
        
    }
}
