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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name.capitalized
        updateInfo()
    }
    func updateInfo() {
        DispatchQueue.main.async {
            if let url = URL(string: "http://images-of-elements.com/\(self.element.name.lowercased()).jpg") {
                ImageHelper.shared.fetchImage(urlString: url.absoluteString) { (appError, image) in
                    if let appError = appError {
                        print("Image Error \(appError)")
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
}
