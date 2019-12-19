//
//  FavouritesViewController.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    let favouritesURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    var elements = [Element]() {
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureRefreshControl()
    }
    
    @objc
    private func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        
        ElementAPI.getElements(favouritesURL) { [weak self] result in
            
            DispatchQueue.main.async{
                self?.refreshControl.endRefreshing()
            }
            
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Element Error", "Could not retrieve favourites. Error: \(netError).")
                }
            case .success(let elementArr):
                self?.elements = elementArr.filter{ $0.favouritedBy == "Cameron Rivera"}
            }
        }
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(setUp), for: .valueChanged)
    }
}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            showAlert("Cell Error", "Could not dequeue UITableViewCell as an ElementCell")
            return UITableViewCell()
        }
        
        do{
            try xCell.setUp(elements[indexPath.row])
        } catch {
            showAlert("Cell Configuration Error", "Could not configure cell. Error: \(error)")
        }
        
        return xCell
    }
}

extension FavouritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedElementVC = newStoryboard.instantiateViewController(identifier: "detailedElementVC") as? DetailedElementViewController else {
            showAlert("Segue Error", "Could not instantiate instance of DetailedElementViewController")
            return
        }
        detailedElementVC.currentElement = elements[indexPath.row]
        detailedElementVC.enableOrDisable = false
        navigationController?.pushViewController(detailedElementVC, animated: true)
    }
}
