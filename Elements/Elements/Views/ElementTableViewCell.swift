//
//  ElementTableViewCell.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementDetailedInfo: UILabel!
    
    public func configureCell(element: Element) {
        elementName.text = element.name
        elementDetailedInfo.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        elementImage.image = UIImage(named: "placeholderImage")
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(formatElementNumber.elementNumberWithThreeDigits(element: element))/s7.JPG"
        ImageHelper.shared.fetchImage(urlString: imageURL) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                self.elementImage.image = image
            }
        }
    }
}


