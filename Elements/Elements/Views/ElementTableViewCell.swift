//
//  ElementTableViewCell.swift
//  Elements
//
//  Created by Aaron Cabreja on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    
    public func configureCell(element: Element) {
        let elementNumber = element.number
        switch elementNumber {
        case 0...9:
            let urlString = "http://www.theodoregray.com/periodictable/Tiles/00\(elementNumber)/s7.JPG"
            if let image = ImageHelper.shared.image(forKey: urlString as NSString) {
                elementImage.image = image
            } else {
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        self.elementImage.image = image
                    }
                }
            }

        case 10...99:
            let urlString = "http://www.theodoregray.com/periodictable/Tiles/0\(elementNumber)/s7.JPG"
            if let image = ImageHelper.shared.image(forKey: urlString as NSString) {
                elementImage.image = image
            } else {
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        self.elementImage.image = image
                    }
                }
            }
        default:
            let urlString = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber)/s7.JPG"
            if let image = ImageHelper.shared.image(forKey: urlString as NSString) {
                elementImage.image = image
            } else {
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        self.elementImage.image = image
                    }
                }
            }
        }
      
        nameLabel?.text = element.name
        symbolLabel?.text = element.symbol

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
