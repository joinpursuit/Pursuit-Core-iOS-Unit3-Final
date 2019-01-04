//
//  SecondViewController.swift
//  Elements
//
//  Created by Biron Su on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var element: Elements!
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var secondSymbol: UILabel!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var secondWeight: UILabel!
    @IBOutlet weak var secondMelt: UILabel!
    @IBOutlet weak var secondBoil: UILabel!
    @IBOutlet weak var secondDiscoveredBy: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name.capitalized
        updateInfo()
    }
    func updateInfo() {
        DispatchQueue.main.async {
            if let url = URL(string: "http://images-of-elements.com/\(self.element.name.lowercased()).jpg") {
                ImageHelper.shared.fetchImage(urlString: url.absoluteString) { (appError, image) in
                    if let _ = appError {
                        if let url = URL(string: "https://sciencenotes.org/wp-content/uploads/2015/04/\(String(format: "%02d", self.element.number))-\(self.element.name.capitalized)-Tile.png") {
                            ImageHelper.shared.fetchImage(urlString: url.absoluteString, completionHandler: { (appError, image) in
                                if let appError = appError {
                                    print("SecondImage Error : \(appError)")
                                } else if let image = image {
                                    self.secondImage.image = image
                                }
                            })
                            
                        }
                    } else if let image = image {
                        self.secondImage.image = image
                    }
                }
            }
        }
        secondSymbol.text = "Symbol: \(element.symbol)"
        secondName.text = "Name: \(element.name.capitalized)"
        secondWeight.text = "Atomic Mass: \(element.atomic_mass)"
        if let melt = element.melt {
            secondMelt.text = "Melting Point: \(melt)"
        } else {
            secondMelt.text = "No Melting Point"
        }
        if let boil = element.boil {
            secondBoil.text = "Boiling Point: \(boil)"
        } else {
            secondBoil.text = "No Boiling Point"
        }
        if let discoveredBy = element.discovered_by {
            secondDiscoveredBy.text = "Discovered by: \(discoveredBy)"
        } else {
            secondDiscoveredBy.text = "No idea who found this."
        }
    }
    
    @IBAction func favoritePost(_ sender: UIButton) {
        let faveElement = Favorite.init(favoritedBy: "Potato", elementName: element.name, elementSymbol: element.symbol)
        do {
            let data = try JSONEncoder().encode(faveElement)
            ElementAPIClient.favoriteElement(data: data) { (success) in
                if success {
                    print("Worked")
                } else {
                    print("Didn't work")
                }
            }
        } catch {
            print("didn't work at all")
        }
    }
}
