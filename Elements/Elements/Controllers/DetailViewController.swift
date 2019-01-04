//
//  DetailViewController.swift
//  Elements
//
//  Created by Matthew Huie on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
 
    public var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(element.name)"
        updateUI()
    }
    
    private func updateUI() {
        ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                self.elementImage.image = image
            }
        }
        elementSymbol.text = element.symbol
        elementNumber.text = "Number: \(String(element.number))"
        elementWeight.text = "Atomic Mass: \(String(element.atomic_mass))"
        meltingPoint.text = "Melting Point: \(element.melt?.description ?? "null")"
        boilingPoint.text = "Boiling Point: \(element.boil?.description ?? "null")"
        discoveredBy.text = "Discovered By: \(element.discovered_by ?? "null")"
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(favoritedBy: Constants.Name, elementName: element.name, elementSymbol: element.symbol)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElements(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Successfully Favorited Element", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Was Not Favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    

   
}
