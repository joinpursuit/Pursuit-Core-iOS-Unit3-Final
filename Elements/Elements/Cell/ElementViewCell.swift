//
//  ElementViewCell.swift
//  Elements
//
//  Created by Diego Estrella III on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementViewCell: UITableViewCell {
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    
    public func cellIcon() {
        if let image = ImageHelper.shared.image(forKey: "http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG") {
          elementImage.image = image
        }
    }
}
