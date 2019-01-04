//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Diego Estrella III on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    public var element: Element!
    
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
    }
    
    private func uploadData() {
        title = element.name
        elementSymbol.text = "Symbol:  \(element.symbol)"
        elementNumber.text = "Element Number:  \(element.number)"
        atomicWeight.text = String(format: "Atomic Mass:  %.2f", element.atomicMass)
        meltingPoint.text = String(format: "Melting Point:  %.2f", element.melt ?? 0.0)
        boilingPoint.text = String(format: "Boiling Point:  %.2f", element.boil ?? 0.0)
        discoveredBy.text = "Dicovered by:  \(element.discoveredBy ?? "Unkown")"
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(name: element.name, number: element.number, symbol: element.symbol)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.getFavoriteElement(data: data) { (appError, success) in
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
