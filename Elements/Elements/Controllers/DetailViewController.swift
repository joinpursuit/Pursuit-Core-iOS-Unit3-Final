//
//  DetailViewController.swift
//  Elements
//
//  Created by Nathalie  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var element: Element!
    
    @IBOutlet weak var elementimage: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementMass: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var elementDiscoveredBy: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
        title = element.name
    }
    
    func updateUI() {
        elementNumber.text = String(element.number)
        elementSymbol.text = element.symbol
        elementName.text = element.name
        elementMass.text = "Atomic Mass: \(String(element.atomic_mass))"
        if let melt = element.melt {
            meltingPoint.text = "Melting point: \(String(melt))"
        }
        if let boil = element.boil {
            boilingPoint.text = "Boiling point: \(String(boil))"
        }
        if let person = element.discovered_by {
            elementDiscoveredBy.text = "Discovered by: \(person)"
        }
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(element.name.lowercased()).jpg" as NSString) {
            elementimage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementimage.image = image
                }
            }
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func addFavorites(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(favoritedBy: "Nathalie", elementName: element.name, elementSymbol: element.symbol)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementsAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully favorited element", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}


