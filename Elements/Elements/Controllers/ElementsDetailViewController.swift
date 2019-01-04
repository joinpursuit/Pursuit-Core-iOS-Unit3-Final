//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Genesis Mosquera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var elementsImage: UIImageView!
    @IBOutlet weak var elementsName: UILabel!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementsNumber: UILabel!
    @IBOutlet weak var elementsWeight: UILabel!
    @IBOutlet weak var elementsMeltingPoint: UILabel!
    @IBOutlet weak var elementsBoilingPoint: UILabel!
    @IBOutlet weak var elementsDiscoverer: UILabel!
    
    
    public var element: Elements!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateUI()
    }
    
    private func updateUI(){
        if let nameText = element?.name {
            elementsName.text = nameText
        } else {
            elementsName.text = "No name for this element"
        }
        if let symbolText = element?.symbol {
            elementSymbol.text = symbolText
        } else {
            elementSymbol.text = "No symbol for this element"
        }
        if let numberField = element?.number {
            elementsNumber.text = "\(numberField)"
        } else {
            elementsNumber.text = "Mp"
        }
        if let weightField = element?.atomic_mass {
            elementsWeight.text = "\(weightField)"
        } else {
            elementsWeight.text = "No weight for this element"
        }
        if let meltingText = element?.melt {
            elementsMeltingPoint.text = "\(meltingText)"
        } else {
            elementsMeltingPoint.text = "No melting point for this element"
        }
        if let boilingText = element?.melt {
            elementsBoilingPoint.text = "\(boilingText)"
        } else {
            elementsBoilingPoint.text = "No boiling point for this element"
        }
        if let discoveryText = element?.discovered_by {
            elementsDiscoverer.text = discoveryText
        } else {
            elementsMeltingPoint.text = "No name given for who discovered this element"
        }
        if let image = ImageHelper.shared.image(forKey: element.spectral_img.absoluteString as NSString) {
            elementsImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: element.spectral_img.absoluteString) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementsImage.image = image
                }
            }
        }
    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        let favorite = Favorites.init(favoritedBy: Constants.Name, elementName: element.name, elementSymbol: element.symbol, spectral_img: element.spectral_img)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementsAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully favorited podcast", message: "")
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


