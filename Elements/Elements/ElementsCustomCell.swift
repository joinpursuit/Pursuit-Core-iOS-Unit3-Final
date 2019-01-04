//
//  ElementsCustomCell.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsCustomCell: UITableViewCell {


  @IBOutlet weak var elementName: UILabel!
  
  @IBOutlet weak var elementInfo: UILabel!
  
  @IBOutlet weak var elementImage: UIImageView!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  private var urlString = ""
  
  public func configureCell(element: Elements) {
    
    urlString = "http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG"
    
    elementName.text = element.name
    elementInfo.text = "\(element.symbol) (\(element.number)) \(element.atomic_mass)"
    if let image = ImageHelper.shared.image(forKey: urlString as NSString) {
      elementImage.image = image
    } else {
      activityIndicator.startAnimating()
      ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
        if let appError = appError {
          print(appError.errorMessage())
        } else if let image = image {
          if self.urlString == self.urlString {
            self.elementImage.image = image
          }
        }
        self.activityIndicator.stopAnimating()
      }
    }
  }
}
