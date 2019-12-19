//
//  FavoritesTableViewController.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/13/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let elementsURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    private let elements2URL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
    private let favoritesURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    
    private let name = "Ahad"
    
    var elements = [Element]()
    var favorites = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var filteredElements: [Element] {
        let favoriteElements = favorites.map {$0.name }
        return elements.filter { favoriteElements.contains($0.name)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavorites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ElementDetailViewController {
            destVC.element = filteredElements[tableView.indexPathForSelectedRow!.row]
            destVC.title = filteredElements[tableView.indexPathForSelectedRow!.row].name
        }
    }
    
    private func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func updateFavorites() {
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: favoritesURL) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting JSON from favorites: \(error)")
            case .success(let favoritesFromAPI):
                self.favorites = favoritesFromAPI.filter {$0.favoritedBy == self.name}
            }
        }
    }
    
    private func loadData() {
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: elementsURL) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting JSON from elements: \(error)")
            case .success(let elementsFromAPI):
                self.elements = elementsFromAPI
            }
        }
        
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: elements2URL) { result in
            switch result {
            case .failure(let error):
                print("Error occured getting json from elements_remaining: \(error)")
            case .success(let elementsFromAPI):
                self.elements.append(contentsOf: elementsFromAPI)
            }
        }
        
    }
}

extension FavoritesTableViewController: UITableViewDelegate {}
extension FavoritesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as? ElementCell else {
            print("Cell could not be made using identifier")
            return UITableViewCell()
        }
        let element = filteredElements[indexPath.row]
        let thumbnailURL = "https://www.theodoregray.com/periodictable/Tiles/\(element.elementNumberInString)/s7.JPG"

        cell.nameLabel.text = element.name
        cell.infoLabel.text = "\(element.symbol)(\(element.name)) \(element.atomicMass)"
        cell.elementImageView.getImage(with: thumbnailURL) { (result) in
            switch result {
            case .failure(let error):
                print("Error getting image: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.elementImageView.image = image
                }
            }
        }
        return cell
    }
}
