//
//  FavoriteElementsViewController.swift
//  Elements
//
//  Created by Donkemezuo Raymond Tariladou on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteElementsViewController: UIViewController {
    @IBOutlet weak var favoriteElementTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteElementTableView.dataSource = self
        self.favoriteElementTableView.delegate = self
        fetchFavoriteElement()

    }
    
    private var favoriteElements = [Favorite](){
        didSet {
        DispatchQueue.main.async {
            self.favoriteElementTableView.reloadData()
        }
    }

}
    func fetchFavoriteElement (){
        PeriodicElementAPIClient.getFavoriteElement { (appError, favorites) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let favoriteElement = favorites {
                DispatchQueue.main.async {
                    self.favoriteElements = favoriteElement.filter({ (Favorite) -> Bool in
                        Favorite.favoritedBy == "Raymond Donkemezuo"
                    })
                }
            }
        }
    }
    
    
}
extension FavoriteElementsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = favoriteElementTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let favorite = favoriteElements[indexPath.row]
        cell.textLabel?.text = favorite.elementName
        
        return cell
    }
}

extension FavoriteElementsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
