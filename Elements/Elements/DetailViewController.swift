//
//  DetailViewController.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementDetailLabel: UILabel!
    @IBOutlet weak var meltBoilLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        guard let detailVCElement = element else {
            fatalError("Error: Couldn't pull Element, check prepare for segue")
        }
        elementNameLabel.text = detailVCElement.name
        elementDetailLabel.text = "\(detailVCElement.symbol) (\(detailVCElement.number)) - \(detailVCElement.atomic_mass)"
        meltBoilLabel.text = "Melt Point: \(detailVCElement.melt ?? -0.1) - Boil Point: \(detailVCElement.boil ?? -0.1)"
        discoveredByLabel.text = "Discovered by " + (detailVCElement.discovered_by ?? "Unknown")
    }
    
}
