//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementMeltingPoint: UILabel!
    @IBOutlet weak var elementBoilingPoint: UILabel!
    @IBOutlet weak var elementDiscoveryBy: UILabel!
    
    var element: Element!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        elementName.text = element.name
        elementNumber.text = element.number.description
        elementWeight.text = String(format: "%.3f", element.atomic_mass)
        elementSymbol.text = element.symbol

        if let meltingPoint = element.melt {
            elementMeltingPoint.text = "Melting Point: " + meltingPoint.description
        } 
        
        if let boilingPoint = element.boil {
            elementBoilingPoint.text = "Boiling Point: " + boilingPoint.description
        }
        
        if let discoverPerson = element.discovered_by {
            elementDiscoveryBy.text = "Discovery By: " + discoverPerson
        }
        let imageURL = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        ImageHelper.shared.fetchImage(urlString: imageURL) { (appError, image) in
            if let appError = appError {
                self.elementImage.image = UIImage(named: "placeholderImage")
                print(appError.errorMessage())
            } else if let image = image {
                self.elementImage.image = image
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        let favorite = Favorite.init(elementName: element.name, favoritedBy: Constants.Name, elementSymbol: element.symbol)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Successfully favorited element", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "element was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}
