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
        var threeDigitNum = ""
        switch element.number {
        case 0...9: threeDigitNum = "00\(element.number)"
        case 10...99: threeDigitNum = "0\(element.number)"
        default:
            threeDigitNum = "\(element.number)"
        }
//        urlString = element.spectral_img.absoluteString
//
        elementName.text? = element.name
        elementSymbol.text? = element.symbol
        ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\(threeDigitNum)/s7.JPG") { (error, image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.elementImage?.image = image
                    
                }
                
            } else if let error = error {
                print(error)
            }
        }
        
//        if let image = ImageHelper.shared.image(forKey: element.spectral_img.absoluteString as NSString) {
//            elementImage.image = image
//        } else {
//            activityIndicator.startAnimating()
//            ImageHelper.shared.fetchImage(urlString: element.spectral_img.absoluteString) { (appError, image) in
//                if let appError = appError {
//                    print(appError.errorMessage())
//                } else if let image = image {
//                    if self.urlString == element.spectral_img.absoluteString {
//                        self.elementImage.image = image
//                    }
//                }
//                self.activityIndicator.stopAnimating()
//            }
//        }
    }
//}

}
