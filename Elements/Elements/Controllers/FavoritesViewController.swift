//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Genesis Mosquera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var favorites = [Favorites](){
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
        fetchFavorites()
    }
    
    private func fetchFavorites() {
        guard let encodedName = Constants.Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        ElementsAPIClient.getFavorites(name: encodedName) { (appError, favorites) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.elementName
//        if let image = ImageHelper.shared.image(forKey: favorite.spectral_img.absoluteString as NSString) {
//            cell.imageView?.image = image
//        } else {
//            ImageHelper.shared.fetchImage(urlString: favorite.spectral_img.absoluteString) { (appError, image) in
//                if let appError = appError {
//                    print(appError.errorMessage())
//                } else if let image = image {
//                    cell.imageView?.image = image
//                }
//            }
//        }
        return cell
    }
}

