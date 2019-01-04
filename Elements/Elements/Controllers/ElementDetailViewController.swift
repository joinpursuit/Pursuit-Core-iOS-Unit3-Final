//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Stephanie Ramirez on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet var detailBackgroundView: UIView!
    @IBOutlet weak var elementDetailName: UILabel!
    @IBOutlet weak var elementDetailView: UIView!
    @IBOutlet weak var elementDetailSymbol: UILabel!
    @IBOutlet weak var elementDetailNumber: UILabel!
    @IBOutlet weak var elementDetailWeight: UILabel!
    @IBOutlet weak var elementDetailMelt: UILabel!
    @IBOutlet weak var elementDetailBoil: UILabel!
    @IBOutlet weak var elementDetailDiscover: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
    public var element: ElementData!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateObject()

    }
    
    private func updateObject() {
        let imageUrl = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        if let image = ImageHelper.shared.image(forKey: imageUrl as NSString) {
            detailBackgroundView.backgroundColor = UIColor(patternImage: image)
        } else {
            ImageHelper.shared.fetchImage(urlString: imageUrl) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.detailBackgroundView.backgroundColor = UIColor(patternImage: image)
                }
            }
        }
        elementDetailName.text = element.name
        elementDetailSymbol.text = element.symbol
        elementDetailNumber.text = String(element.number)
        elementDetailWeight.text = String(element.atomicMass)
        if let discovered = element.discoveredBy {
            elementDetailDiscover.text = "Discovered by: \(discovered)"
        }
        if let melt = element.melt {
            elementDetailMelt.text = "Melting Point: \(String(melt))"
        }
        if let boil = element.boil {
            elementDetailBoil.text = "Boiling Point: \(String(boil))"
        }
    }
    
    
    
    

    @IBAction func favoritesPressed(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(name: element.name, favoritedBy: "Stephanie")
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success {
                    print("successfully favorited podcast")
                } else {
                    print("was not favorited")
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}
