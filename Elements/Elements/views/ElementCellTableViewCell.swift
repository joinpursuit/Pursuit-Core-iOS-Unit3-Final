//
//  ElementCellTableViewCell.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCellTableViewCell: UITableViewCell {
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementDescription: UILabel!
    private var threedigitsString = ""
    
    public func configureCell(element: Element) {
        backgroundColor = UIColor.init(displayP3Red: CGFloat(240)/255, green: CGFloat(128)/255, blue: CGFloat(128)/255, alpha: 1)
        if element.number < 10 {
            threedigitsString = "00\(element.number)"
        } else if element.number >= 10 && element.number < 100 {
            threedigitsString = "0\(element.number)"
        }
        elementName.text = "\(element.name)"
        elementDescription.text = "\(element.symbol)(\(element.number)) | Atomic weight: \(String(format: "%.3f", element.atomic_mass))"
        if let image = ImageHelper.shared.image(forKey: "http://www.theodoregray.com/periodictable/Tiles/\(threedigitsString)/s7.JPG" as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\(threedigitsString)/s7.JPG") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
                }
            }
        }
    }
}
