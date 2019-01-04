//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var myfavorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        fetchFavorites(name: Constants.Name)
    }
    private func fetchFavorites(name: String) {
        ElementAPIClient.getMyFavorites() { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.myfavorites = favorites.filter{ $0.favoritedBy == name }
            }
        }
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myfavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favoriteToSet = myfavorites[indexPath.row]
        cell.textLabel?.text = favoriteToSet.elementName
        return cell
    }
}
