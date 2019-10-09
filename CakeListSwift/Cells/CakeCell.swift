//
//  CakeCell.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import Foundation
import UIKit

class CakeCell: UITableViewCell {
    
    @IBOutlet private weak var cakeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var cake: Cake? {
        didSet {
            titleLabel.text = cake?.title
            descriptionLabel.text = cake?.desc
            cakeImageView.image = #imageLiteral(resourceName: "imageNotFound")
        }
    }
    
    func updateCellWithImage(image :UIImage) {
        cakeImageView.image = image
    }
}
