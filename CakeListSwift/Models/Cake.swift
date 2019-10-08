//
//  Cake.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import Foundation

struct Cake: Codable {
    var title: String
    var desc: String
    var imageURL: String
    
    enum CodingKeys:String, CodingKey {
        case title
        case desc
        case imageURL = "image"
    }
}

