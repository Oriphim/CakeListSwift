//
//  ViewController.swift
//  CakeListSwift
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import UIKit

class CakeListViewController: UITableViewController {
    
    var viewModel = CakeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cake Recipes"
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
        downloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfCakes()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(viewModel.countOfCakes() > 0) {
            tableView.separatorStyle = .singleLine
            return 1
        } else {
            Empty()
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CakeCell", for: indexPath) as! CakeCell
        let cake = viewModel.cakeAtIndex(index: indexPath.row)
        cell.cake = cake
        viewModel.imageDataForCake(cake: cake) { (image) in
            DispatchQueue.main.async { //Checks for cell re-use via index rather than visibility to prevent caching
                let cellIndex = tableView.indexPath(for: cell)
                if (cellIndex?.row == indexPath.row) {
                    cell.updateCellWithImage(image: image)
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "cakeDetail") as? CakeDetailViewController else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let cake = viewModel.cakeAtIndex(index: indexPath.row)
        vc.cake = cake
        vc.image = viewModel.cakeImageCache(cake: cake)!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func downloadData() {
        refreshControl?.beginRefreshing()
        viewModel.downloadCakeData(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }) { (errorMessage) in
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
                let messageTitle = NSLocalizedString("downloadErrorTitle", comment: "Message Title")
                let messageConfirmationText = NSLocalizedString("downloadErrorConfirmation", comment: "Ok button")
                let ac = UIAlertController(title: messageTitle, message: errorMessage , preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: messageConfirmationText, style: .default, handler: nil))
                self?.present(ac, animated: true)
            }
        }
    }
    
    func Empty() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        messageLabel.text = "No Cakes To Be Found 😰"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 17)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }

}

