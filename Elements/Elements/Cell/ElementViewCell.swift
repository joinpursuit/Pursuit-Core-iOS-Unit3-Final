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
    
    public func updateCellIcon(element: Element) {

        ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/00\(element.number)/s7.JPG") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                self.elementImage.image = image
                
            }
        }
    }
}
