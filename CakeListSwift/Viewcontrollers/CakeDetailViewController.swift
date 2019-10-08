//
//  CakeDetailViewController.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import UIKit

class CakeDetailViewController: UIViewController
{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cakeImage: UIImageView!
    
    var cake: Cake?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = cake?.title
        descriptionLabel.text = cake?.desc
        cakeImage.image = image
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.stackView.axis = .horizontal
            } else {
                self.stackView.axis = .vertical
            }
        })
    }
}
