//
//  FavoriteViewController.swift
//  Elements
//
//  Created by Jason on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var FavoriteElements: UITableView!
    
    var favoriteElement = [FavoriteElement](){
        didSet{
            DispatchQueue.main.async {
                self.FavoriteElements.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
FavoriteElements.dataSource = self
        updateTheFavoriteElements()
        // Do any additional setup after loading the view.
    }
    
    private func updateTheFavoriteElements(){
        ElementAPI.favoriteElemntsChosen{ (error, favElement) in
            if let error = error{
                print(error)
            }
            else if let data = favElement{
                self.favoriteElement = data
            }
        }
    }
    
    
  

}


extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteElement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = FavoriteElements.dequeueReusableCell(withIdentifier: "favoriteElementCell") else {return UITableViewCell()}
        let element = favoriteElement[indexPath.row]
        
        cell.textLabel?.text = element.elementName

        
        
        return cell
    }
    
    
}

