//
//  FavoriteViewController.swift
//  Elements
//
//  Created by Biron Su on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var favorite = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var favoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteElements()
    }
    private func getFavoriteElements() {
        ElementAPIClient.getFavoriteElement(keyword: "Potato") { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.favorite = favorites
            }
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else {return FavoriteTableViewCell()}
        let cellToSet = favorite[indexPath.row]
        cell.favoriteElement.text = "\(cellToSet.elementName)(\(cellToSet.elementSymbol))"
        cell.favoritedBy.text = "Favorited By: \(cellToSet.favoritedBy)"
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
