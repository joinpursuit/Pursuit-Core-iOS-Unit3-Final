//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Oscar Victoria Gonzalez  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    
@IBOutlet weak var elementImageView: UIImageView!
@IBOutlet weak var symbolLabel: UILabel!
@IBOutlet weak var weightLabel: UILabel!
@IBOutlet weak var meltingLabel: UILabel!
@IBOutlet weak var boilingLabel: UILabel!
@IBOutlet weak var discoveredLabel: UILabel!
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var numbelLabel: UILabel!
    
    
    
    var element: Elements?
    
    var favoriteElements: FavoriteElements?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let elements = element else {
            fatalError("error")
        }

        let imageURL = "http://images-of-elements.com/\(element?.name.lowercased() ?? "").jpg"
        
        
        title = elements.name
        numbelLabel.text = element?.number.description
        nameLabel.text = element?.name
        symbolLabel.text = element?.symbol
        weightLabel.text = element?.atomic_mass.description
        meltingLabel.text = "Melting: \(element?.melt?.description ?? "")"
        boilingLabel.text = "Boiling: \(element?.boil?.description ?? "")"
        discoveredLabel.text = "Discovered by: \(element?.discovered_by ?? "")"
        elementImageView.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.elementImageView.image = image
                }
            }
        }
        


        
//        guard let favElement = favoriteElements else {
//            fatalError("error")
//        }
//
//        title = element?.name
//        symbolLabel.text = favElement.symbol
//        weightLabel.text = favElement.atomic_mass.description
//        meltingLabel.text = favElement.melt?.description
//        boilingLabel.text = favElement.boil?.description
//        discoveredLabel.text = favElement.discovered_by
    
    }
    

    @IBAction func favoriteButton(_ sender: UIButton) {
        
        print("button pressed")
        
        guard let someElement = element else {
            fatalError("error")
        }

        
        let favorites = Elements(name: someElement.name, appearance: someElement.appearance, symbol: someElement.symbol, number: someElement.number, atomic_mass: someElement.atomic_mass, melt: someElement.melt, boil: someElement.boil, discovered_by: someElement.discovered_by, favoritedBy: "Oscar V")
        
        ElementsAPIClient.postFavorites(element: favorites) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success:
                print("success")
            }
        }
    }
    
    
}
