//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jason on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var elemental: Element!
    
    
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMelting: UILabel!
    @IBOutlet weak var elementBoiling: UILabel!
    @IBOutlet weak var elementDiscoveredBy: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheLook()
        // Do any additional setup after loading the view.
    }
    
    func updateTheLook(){
        title = elemental.name
        elementSymbol.text = "Elements Symbol: \(elemental.symbol)"
        elementNumber.text = "Element Atomic Number: \(elemental.number)"
        elementWeight.text = "Element Atomic Mass: \(elemental.atomic_mass)"
        if elemental?.boil == nil{
            elementBoiling.text = "This element has no boiling point"
        }
        else{
            elementBoiling.text = "Element Boiling Point: \(elemental.boil ?? 0)"
        }
        if elemental.melt == nil{
            elementMelting.text = "This element has no melting point"

        }
        else{
            elementMelting.text = "Element Melting Point: \(elemental.melt ?? 0)"
        }
        elementDiscoveredBy.text = "Element Discorver by: " + (elemental.discovered_by ?? "N/A")
    
    
        ImageHelper.shared.fetchImage(urlString:  "http://images-of-elements.com/\(elemental.name.lowercased()).jpg") { (appError, image) in
            if let error = appError{
                print(error)
            }
            else if let pic = image{
                DispatchQueue.main.async {
                self.elementImage.image = pic
                }
            }
    }
}

    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let favorite = FavoriteElement.init(elementName: elemental.name, elementSymbol: elemental.symbol, favoritedBy: "Jason")
        
        do{
            let data = try JSONEncoder().encode(favorite)
            ElementAPI.favoriteElement(data: data) { (appError, success) in
                if let appError = appError{
                    print(appError)
                }
                else if success{
                    print(success)
                }
                else{
                    print("was not fav")
                }
            }
        }
        catch{
            print(error)
        }
        
        
    }
}

