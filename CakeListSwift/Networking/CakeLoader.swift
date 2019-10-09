//
//  CakeLoader.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import Foundation
import UIKit

struct CakeLoader {
    
    enum ImageDataError: Error {
        case wrongImageData
    }
    // Enums to cover web networking errors
    enum DownloadDataError: Error {
        case webResponseCodeError
        case dataError
        case serverError
    }
    
    func startDataDownloadTaskWithURL(urlString: String,
                                      completionHandler: @escaping (Result<Data, DownloadDataError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.webResponseCodeError))
                return
            }
            
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300) {
                guard let returnData = data else {
                    completionHandler(.failure(.dataError))
                    return
                }
                completionHandler(.success(returnData))
            } else {
                completionHandler(.failure(.serverError))
                }
        }.resume()
    }
    
    func downloadDataWithURL(urlString: String,
                             completionHandler: @escaping (Result<Data, DownloadDataError>) -> Void) {
        startDataDownloadTaskWithURL(urlString: urlString) { result  in
            completionHandler(result)
        }
    }
    
    func downloadImageWithURL(urlString: String,
                              completionHandler: @escaping (Result<UIImage, ImageDataError>) -> Void) {
        startDataDownloadTaskWithURL(urlString: urlString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completionHandler(.failure(.wrongImageData))
                    return
                }
                completionHandler(.success(image))
            case .failure:
                completionHandler(.failure(.wrongImageData))
            }
        }
    }
}
