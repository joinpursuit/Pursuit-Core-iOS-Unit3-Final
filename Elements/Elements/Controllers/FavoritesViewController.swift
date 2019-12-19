//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFavorites()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("couldnt get indexpath or detailVC")
        }
        detailVC.element = favorites[indexPath.row]
    }

    
    func loadFavorites() {
        ElementAPIClient.getFavorites { [weak self] (result) in // strong reference
                   switch result {
                       case .failure(let appError):
                       DispatchQueue.main.async {
                           self?.showAlert(title: "App Error", message: "\(appError)")
                       }
                   case .success(let favoriteElements):
                    self?.favorites = favoriteElements.filter {$0.favoritedBy == "Ameni A."}
                   }
               }
        
    }
    


}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("could not down cast to custom cell - reusable identifier/ cell class")
        }
        
        let favorite = favorites[indexPath.row]
        
        cell.configureCell(for: favorite)
        
        return cell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
