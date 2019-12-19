//
//  ElementCell.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    

    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementInfoLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        elementImage.layer.cornerRadius = elementImage.frame.width/13
    }
   
    func configureCell(for element: Element) {
        
        elementNameLabel.text = element.name
        elementInfoLabel.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        
        // get thumbnail image
        
        
    }

}
