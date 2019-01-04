//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Alyson Abril on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var elementDetailImage: UIImageView!
    @IBOutlet weak var nameSymbolLabel: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var meltPoint: UILabel!
    @IBOutlet weak var boilPoint: UILabel!
    @IBOutlet weak var discoveredLabel: UILabel!
    
    
    public var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateElementInfo()
    }
    
    
    func updateElementInfo () {
        nameSymbolLabel.text = String("\(element.name)(\(element.symbol))")
        elementNumber.text = String(element.number)
        elementWeight.text = String(element.atomicMass)
        meltPoint.text = String(format:"%f", element.melt ?? "melting point not found")
        boilPoint.text = String(format:"%f", element.boil ?? "boiling point not found")
        discoveredLabel.text = element.discoveredBy
    }
    
}
