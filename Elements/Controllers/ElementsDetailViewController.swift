//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Oscar Victoria Gonzalez  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    
    
    
    
    
    
    var element: Elements?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let elements = element else {
            fatalError("error")
        }
        title = elements.name
    }

    
}
