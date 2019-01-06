//
//  DetailElementVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementVC: UIViewController {
    
    public var element: Element!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveryBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateLabels()
    }
    
    func updateLabels() {
        
        if let melt = element.melt{
            meltingPoint.text = "Melting Point: \(melt.description)"
        }
        if let boil = element.boil {
            boilingPoint.text = "Boiling Point: \(boil.description)"
        }
        if let discover = element.discoveredBy {
            discoveryBy.text = "Discovered By: \(discover)"
        }
        symbol.text = "Element Symbol: \(element.symbol)"
        number.text = "Element Number: \(element.number)"
        weight.text = "Atomic Mass: \(element.atomicMass)"
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addToFavorite(_ sender: UIBarButtonItem) {
        let favorite = Favorite(favoritedBy: "Joshua Viera", elementName: element.name, elementSymbol: element.symbol)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    self.showAlert(title: "Error Message:", message: appError.errorMessage())
                } else if success {
                    self.showAlert(title: "Successsfully Favorited \(self.element.name)", message: "")
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
