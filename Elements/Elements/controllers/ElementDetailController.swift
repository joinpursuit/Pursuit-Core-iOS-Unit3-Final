//
//  ElementDetailController.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
//symbol
//number
//weight
//melting point
//boiling point
//discovery by

class ElementDetailController: UIViewController {
    @IBOutlet weak var addToFavorite: UIBarButtonItem!
    @IBOutlet weak var elementDetailImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMeltingPoint: UILabel!
    @IBOutlet weak var elementBoilingPoint: UILabel!
    @IBOutlet weak var elementDiscoveredBy: UILabel!
    @IBOutlet weak var elementDescription: UITextView!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name.uppercased() + " 🔬"
       
        updateUI()
    }
    private func getAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUI() {
        view.backgroundColor = .gray
        elementSymbol.text = "\(element.symbol)"
        elementSymbol.textColor = .white
        elementNumber.text = "Number: \(element.number)"
        elementWeight.text = "Weight: \(String(format: "%.3f", element.atomic_mass))"
        elementMeltingPoint.text = "Melting point: \(String(format: "%.3f", element.melt ?? "unknown melting point"))"
        elementBoilingPoint.text = "Boiling point: \(String(format: "%.3f", element.boil ?? "unkown boilin point"))"
        elementDiscoveredBy.text = "Discovered by: \(element.discovered_by ?? "unknown discovery")"
        elementDescription.text = element.summary
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(element.name.lowercased()).jpg" as NSString) {
            elementDetailImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementDetailImage.image = image
                }
            }
        }
    }
    
    @IBAction func addToFavorite(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(id: "\(element.number)", elementName: element.name, favoritedBy: Fellow.Name, elementSymbol: element.symbol)
        do {
            let data = try JSONEncoder().encode(favorite)
            elementAPIClient.addToFavorites(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.getAlert(title: "Error message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.getAlert(title: "Added to favorites!", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.getAlert(title: "was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("Encoding error \(error)")
        }
    }
}
