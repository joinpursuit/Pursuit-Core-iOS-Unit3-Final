//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Pritesh Nadiadhara on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit


class ElementDetailViewController: UIViewController {
    
    public var elementInfo: Element!
    @IBOutlet weak var largerElementImage: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var boiling: UILabel!
    @IBOutlet weak var melting: UILabel!
    @IBOutlet weak var discovered: UILabel!
    @IBOutlet weak var favoriteElement: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementImageUpdate()
        title = elementInfo.name
        symbol.text = "Symbol: \(elementInfo.symbol)"
        number.text = "Number: \(String(elementInfo.number))"
        weight.text = "Atomic Mass: \(String(elementInfo.atomic_mass))"
        let boil: Double = elementInfo.boil ?? 0.0
        let melt: Double = elementInfo.melt ?? 0.0
        if boil == 0.0 {
            boiling.text = "Boiling Point: N/A)"
        }else {
            boiling.text = "Boiling Point: \(String(boil))"
        }
        if melt == 0.0 {
        melting.text = "Melting Point: N/A)"
        } else {
           melting.text = "Melting Point:  \(String(melt))"
        }
        discovered.text = "Discovered by: \(elementInfo.discovered_by ?? "N/A")"
        
    }
    private func elementImageUpdate() {
        let elementForURL = (elementInfo.name).lowercased()
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(elementForURL).jpg" as NSString) {
            largerElementImage.image = image
        } else {
            
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addTofavs(_ sender: UIButton){
        let favorite = Favorite.init(favoritedBy: "Pritesh", elementName: elementInfo.name, elementSymbol: elementInfo.symbol)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
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
