//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Alfredo Barragan on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
class ElementsDetailViewController: UIViewController {
    
    var element: Element!
    
    @IBOutlet weak var elementPicture: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMeltPoint: UILabel!
    @IBOutlet weak var elementBoilPoint: UILabel!
    @IBOutlet weak var elementTitle: UILabel!
    
    
    @IBOutlet weak var elementDiscoveredBy: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI() {
        elementSymbol.text = element.symbol 
        elementNumber.text = element.number.description
        elementWeight.text = element.atomic_mass.description
        elementMeltPoint.text = "Melting Point: \(String(describing: element.melt))"
        elementBoilPoint.text = "Boiling Point: \(String(describing: element.boil))"
        elementDiscoveredBy.text = "Discovered By: \(element.discovered_by ?? "Unknown")"
        elementTitle.text = element.name
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(element.name.lowercased()).jpg" as NSString) {
            elementPicture.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementPicture.image = image
                }
            }
        }
        
    }
    @IBAction func FavoriteButton(_ sender: Any) {
        let favorite = Favorite.init(favoritedBy: "Alfredo B", elementName: element.name, elementSymbol: element.symbol)
        do{
            let data = try JSONEncoder().encode(favorite)
            ElementalAPIClient.favoriteElement(data: data){(appError, success) in
                if let appError = appError{
                    print(appError.errorMessage())
                } else if success {
                    print("this is my favorite element")
                } else {
                    print("this is not my favorite")
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}


       

    

    


