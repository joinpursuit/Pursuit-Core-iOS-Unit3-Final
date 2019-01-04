//
//  ElementsCell.swift
//  Elements
//
//  Created by Genesis Mosquera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsCell: UITableViewCell {
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var urlString = ""
    
    public func configureCell(element: Elements) {
        
        urlString = element.spectral_img.absoluteString
        
        elementName.text = element.name
        elementSymbol.text = element.symbol
        if let image = ImageHelper.shared.image(forKey: element.spectral_img.absoluteString as NSString) {
            elementImage.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.shared.fetchImage(urlString: element.spectral_img.absoluteString) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    if self.urlString == element.spectral_img.absoluteString {
                        self.elementImage.image = image
                    }
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

