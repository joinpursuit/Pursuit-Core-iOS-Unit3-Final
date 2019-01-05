//
//  DetailElementVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementVC: UIViewController {

    public var element: Element!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveryBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateLabels()
    }
    
    func updateLabels() {
    
        if let melt = element.melt{
            meltingPoint.text = "Melting Point: \(melt.description)"
        }
        if let boil = element.boil {
            boilingPoint.text = "Boiling Point: \(boil.description)"
        }
        if let discover = element.discoveredBy {
            discoveryBy.text = "Discovered By: \(discover)"
        }
        symbol.text = "Element Symbol: \(element.symbol)"
        number.text = "Element Number: \(element.number)"
        weight.text = "Atomic Mass: \(element.atomicMass)"
    }
}
