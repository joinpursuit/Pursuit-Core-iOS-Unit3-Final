//
//  ElementDetailController.swift
//  Elements
//
//  Created by Pursuit on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailController: UIViewController {

    
    var ElementDetail: Elements!
    
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    
    @IBOutlet weak var DetailLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = ElementDetail.name
        let newName = "\(ElementDetail.name.lowercased())"
        let myName = "http://images-of-elements.com/\(newName).jpg"
       
        let ImageURL = URL.init(string: myName)
        do {
            let data = try Data.init(contentsOf: ImageURL!)
            DetailImage.image = UIImage.init(data: data)
        } catch {
            print("Try again\(error)")
        }
    
        
     DetailLabel.text = """
        
        Symbol:  \(ElementDetail.symbol)
        
        ElementsName:  \(ElementDetail.name)
        
        Atomic Mass:  \(ElementDetail.atomic_mass)
        
        Melting Point:  \(ElementDetail.melt ?? 0 )
        
        Boiling Point:  \(ElementDetail.boil ?? 0 )
        
        Who Discovered Me:  \(ElementDetail.discovered_by ?? "Not Available")
        
        Description -  \(ElementDetail.summary)
        
"""
        
    }
    

    @IBAction func Favoritebutton(_ sender: Any) {
        
        let MyFavorite = Favorite.init(id: "\(ElementDetail.number)", elementName: "\(ElementDetail.name)", favoritedBy: "Antonio please dont kick me from pursuit i tried my best :( and fixed my error <3 ", elementSymbol: "\(ElementDetail.symbol)")
        do {
            let data = try JSONEncoder().encode(MyFavorite)
            ElementAPIClient.MyFavoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success {
                    print("successfully favorited Element")
                } else {
                    print("was not favorited ")
                }
            }
        } catch {
            print("encoding \(error)")
        }
}
        
}

