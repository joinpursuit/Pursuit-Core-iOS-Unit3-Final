//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    var element: Element!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        elementName.text = element.name
        elementNumber.text = String(format: "%.2f", element.atomic_mass)
        elementWeight.text = element.atomic_mass.description
        elementSymbol.text = element.symbol
        
        let imageURL = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        if let url = URL.init(string: imageURL) {
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    elementImage.image = image
                }
            } catch {
                elementImage.image = UIImage(named: "placeholderImage")
            }
        }
        
    }

}
