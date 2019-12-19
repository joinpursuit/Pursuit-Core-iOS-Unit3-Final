//
//  ElementCell.swift
//  Elements
//
//  Created by Yuliia Engman on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    private var urlString = ""
    
    func configureCell(for element: Element) {
        nameLabel.text = element.name
        symbolLabel.text = "\(element.symbol)" + "(\(element.number))" + "   " + "\(element.atomicMass)"
        
        let myInt = String(format: "%03d", element.number)
        
        let imageURL = "https://www.theodoregray.com/periodictable/Tiles/\(myInt)/s7.JPG"
        
        urlString = imageURL
        
        smallImage.getImage(with: imageURL) {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.smallImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.urlString == imageURL {
                        self?.smallImage.image = image
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        smallImage.image = UIImage(systemName: "e.circle.fill")
    }
}
