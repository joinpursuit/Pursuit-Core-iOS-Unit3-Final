//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Diego Estrella III on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    public var element: Element!
    
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
    }
    
    private func uploadData() {
        title = element.name
        elementSymbol.text = "Symbol:  \(element.symbol)"
        elementNumber.text = "Element Number:  \(element.number)"
        atomicWeight.text = String(format: "Atomic Mass:  %.2f", element.atomicMass)
        meltingPoint.text = String(format: "Melting Point:  %.2f", element.melt ?? 0.0)
        boilingPoint.text = String(format: "Boiling Point:  %.2f", element.boil ?? 0.0)
        discoveredBy.text = "Dicovered by:  \(element.discoveredBy ?? "Unkown")"
    }
}
