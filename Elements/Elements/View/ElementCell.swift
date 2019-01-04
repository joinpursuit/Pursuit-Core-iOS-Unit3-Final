//
//  ElementCell.swift
//  Elements
//
//  Created by Kevin Waring on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    
    @IBOutlet weak var elementSymbol: UILabel!
    
    private var urlString = ""
    
    public func configureCell(element: Element) {
        var strNum = "\(element.number)"
        switch element.number {
        case 1...9:
            strNum = ("00" + "\(strNum)")
        case 10...99:
            strNum = ("0" + "\(strNum)")
        default:
            strNum = "\(strNum)"
        }
        
        urlString = "http://www.theodoregray.com/periodictable/Tiles/\(strNum)/s7.JPG"
        elementName.text = element.name
        elementSymbol.text = element.symbol
        if let image = ImageHelper.shared.image(forKey: self.urlString  as NSString) {
            elementImage.image = image
        } else {
            //activityIndicator.startAnimating()
            ImageHelper.shared.fetchImage(urlString: urlString ) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    if self.urlString == self.urlString {
                        self.elementImage.image = image
                    }
                }
                //self.activityIndicator.stopAnimating()
            }
        }
    }
}

