//
//  ElementDetailedViewController.swift
//  Elements
//
//  Created by Donkemezuo Raymond Tariladou on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailedViewController: UIViewController {
    @IBOutlet weak var elementName: UINavigationItem!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMeltingPoint: UILabel!
    @IBOutlet weak var elementBoilingPoint: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
    
    var elementInDetails: Elements!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDetailView()
        fetchLargeImage()
    }
    
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
    let favorite = Favorite.init(elementName: elementInDetails.name, favoritedBy: "Raymond Donkemezuo", elementSymbol: elementInDetails.symbol)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            PeriodicElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success {
                    print("Element was successfully favorited")
                } else {
                    print("Favoriting not successful")
                }
            }
        } catch {
            print("Encountered \(error) while encoding data")
        }
    }
    
    func fetchLargeImage(){
        let largeImageUrl = "http://images-of-elements.com/\(elementInDetails.name.lowercased()).jpg"
        ImageHelper.shared.fetchImage(urlString: largeImageUrl) { (appError, largeImageData) in
            
            if appError != nil {
                DispatchQueue.main.async {
                    self.elementImage.image = UIImage.init(named: "placeholder")

                }
                
                
            } else if let largeImage = largeImageData{
                self.elementImage.image = largeImage
            }
        }
    }

    func populateDetailView(){
        elementName.title = elementInDetails.name
        elementSymbol.text = "Symbol: \(elementInDetails.symbol)"
        elementNumber.text = "Number: \(elementInDetails.number)"
        elementWeight.text = "Weight: \(elementInDetails.atomic_mass)"
        
        if let boilingpoints = elementInDetails.boil {
            elementBoilingPoint.text = "Boiling Point: \(boilingpoints)"
        }
        
        if let meltingpoints = elementInDetails.melt {
            elementMeltingPoint.text = "Melting Point: \(meltingpoints)"
        }
        if let discoverer = elementInDetails.discovered_by{
            
            discoveredBy.text = "DiscoveredBy: \(discoverer)"
        }
    }
}
