//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Leandro Wauters on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    var element: Element!
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNum: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMelting: UILabel!
    @IBOutlet weak var elementBoiling: UILabel!
    @IBOutlet weak var elementDiscovered: UILabel!
    
    @IBOutlet weak var elementName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI() {
        elementSymbol.text = element.symbol
        elementNum.text = element.number.description
        elementWeight.text = element.atomicMass.description
        elementMelting.text = "Melting Point: \(String(describing: element.melt))"
        elementBoiling.text = "Boiling Point: \(String(describing: element.boil))"
        elementDiscovered.text = "Discovered By: \(element.discoveredBy ?? "Unknown")"
        elementName.text = element.name
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(element.name.lowercased()).jpg" as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
                }
            }
        }
        
    }
    @IBAction func favoriteWasTapped(_ sender: Any) {
        let favorite = Favorite.init(favoritedBy: "Leandro Wauters", elementName: element.name, elementSymbol: element.symbol)
        do{
            let data = try JSONEncoder().encode(favorite)
            ElementAPI.favoriteElement(data: data){(appError, success) in
                    if let appError = appError{
                        print(appError.errorMessage())
                    } else if success {
                        print("successfuly favorite element")
                    } else {
                        print("was not favorite")
                    }
                }
            } catch {
                    print("encoding error: \(error)")
            }
}
    
}
