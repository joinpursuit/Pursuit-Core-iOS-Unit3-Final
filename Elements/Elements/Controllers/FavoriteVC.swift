//
//  FavoriteVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func fetchFavorites() {
        guard let encodedName = Constants.Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        ElementAPIClient.getFavorites(name: encodedName) { (appError, favorites) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let favorites = favorites {
                self.favorites = favorites
            }
        }
    }
}

    


extension FavoriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.elementName
        return cell
    }
}
