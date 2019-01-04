//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Leandro Wauters on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var myFavorites = [Favorite](){
        
        didSet{
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
            
        }
    }
    
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        getFavorites()

    }
    

    func getFavorites(){
        ElementAPI.getFavorites{(appError, favorites) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let favorites = favorites{
                let myFavorites = favorites.filter{$0.favoritedBy == "Leandro Wauters"}
                self.myFavorites = myFavorites
            }
        }
    }
    
}
extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myFavoriteToSet = myFavorites[indexPath.row]
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        cell.textLabel?.text = myFavoriteToSet.elementName
        return cell
    }
    
    
}

