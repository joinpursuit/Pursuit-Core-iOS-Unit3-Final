//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var titleElementName: UILabel!
    @IBOutlet weak var elementPhase: UILabel!
    @IBOutlet weak var elementDescription: UITextView!
    
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementNum: UILabel!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementAtomicWeight: UILabel!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateDetailUI()
        
        //***set image here
    }
    
    func updateDetailUI() {
        titleElementName.text = element.name
        elementPhase.text = element.phase
        elementDescription.text = element.summary
        
        elementName.text = element.name
        elementNum.text = element.number.description
        elementSymbol.text = element.symbol
        elementAtomicWeight.text = element.atomicMass.description
    }
    
    
    @IBAction func addToFavorite(_ sender: UIBarButtonItem) {
        //set body
        
        //do (set data & call APIClient) & catch (encoding error)
    }
    
}
