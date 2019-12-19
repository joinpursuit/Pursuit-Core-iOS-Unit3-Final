//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    var favoriteElements = [ElementInfo]() {
        didSet {
           DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFave()
        tableView.dataSource = self
        tableView.delegate = self
        configureRefreshControl()
       
    }
    
    func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl
      
      
      refreshControl.addTarget(self, action: #selector(fetchFave), for: .valueChanged)
    }
    @objc
    func fetchFave() {
        ElementAPIClient.fetchFavorites {[weak self] (result) in
            
            DispatchQueue.main.async {
              self?.refreshControl.endRefreshing()
            }
            switch result {
            case .failure(let appError):
            DispatchQueue.main.async {
              self?.showAlert(title: "Failed fetching favorite", message: "\(appError)")
            }
            case .success(let favorites):
                self?.favoriteElements = favorites.filter {$0.favoritedBy == "Luba" }
            }
        }
    }

   
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not dequeue favoriteCell")
        }
        let element = favoriteElements[indexPath.row]
        cell.configureCell(for: element)
        cell.backgroundColor = .systemIndigo
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
