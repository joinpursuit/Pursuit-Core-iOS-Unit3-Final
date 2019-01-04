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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var urlString = ""
    
    public func configureCell(element: Element) {
        elementName.text = element.name
        elementDetailedInfo.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        elementImage.image = UIImage(named: "placeholderImage")
//        if let safeURL = element.spectral_img?.absoluteString {
//            self.urlString = safeURL
//            if let image = ImageHelper.shared.image(forKey: safeURL as NSString) {
//                elementImage.image = image
//            } else {
//                activityIndicator.startAnimating()
//                ImageHelper.shared.fetchImage(urlString: safeURL) { (appError, image) in
//                    if let appError = appError {
//                        print(appError.errorMessage())
//                    } else if let image = image {
//                        if self.urlString == safeURL {
//                            self.elementImage.image = image
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.activityIndicator.stopAnimating()
//                    }
//                }
//            }
//        }
       
    }

}
