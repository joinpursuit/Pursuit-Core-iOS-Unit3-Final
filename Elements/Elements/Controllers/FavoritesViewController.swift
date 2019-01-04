//
//  FavoritesViewController.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  private var favoritesElements = [FavoriteElement]() {
    didSet {
      DispatchQueue.main.async {
          self.favoritesTable.reloadData()
      }
    }
  }
  
  @IBOutlet weak var favoritesTable: UITableView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      favoritesTable.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getFavorites()
  }
  
  private func getFavorites(){
    ElementAPIClient.getFavorites { (error, elements) in
      if let error = error {
        let errorVC = UIAlertController.errorController(error: error)
        self.present(errorVC, animated: true, completion: nil)
      }
      
      if let elements = elements {
        self.favoritesElements = elements.filter { $0.favoritedBy.lowercased() == "jevon"}
      }
    }
  }

}
extension FavoritesViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard favoritesElements.count > 0 else { return UITableViewCell() }
    let cell = UITableViewCell()
    let favoriteElement = favoritesElements[indexPath.row]
    cell.textLabel?.text = favoriteElement.elementName
    cell.detailTextLabel?.text = favoriteElement.elementSymbol
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritesElements.count
  }
}
