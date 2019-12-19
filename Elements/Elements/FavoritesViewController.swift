//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    var favorites = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        configureRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error: Couldn't prepare segue")
        }
        detailVC.element = favorites[indexPath.row]
    }
    
    func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(getFavorites), for: .valueChanged)
    }

    
    @objc func getFavorites() {
    ElementAPIClient.fetchUserFavorites(completion: { [weak self] (result) in
        
        DispatchQueue.main.async {
          self?.refreshControl.endRefreshing()
        }
        
        switch result {
        case .failure(let appError):
            DispatchQueue.main.async {
                    self?.showAlert(title: "Error: Could not read data", message: "\(appError)")
                }
            case .success(let favorites):
                    self?.favorites = favorites
                }
        }
    )
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? ElementCell else {
            fatalError("Couldn't access ElementCell")
        }
        let favorite = favorites[indexPath.row]
        cell.configureCell(element: favorite)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        207
    }
    
}
