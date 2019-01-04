//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var favorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var name = "Oniel"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "Favorites"
        getFavorites()
    }
    
    func getFavorites() {
      guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        elementAPIClient.getFavorites(name: encodedName) { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.favorites = favorites
            }
        }
        
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.elementName
        cell.detailTextLabel?.text = "favorited by: \(favorite.favoritedBy)"
        return cell
    }
}
