//
//  ElementCell.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var elementImage: UIImageView!
    
    
    
    func configureCell(for element: ElementInfo) {
        nameLabel.text = element.name
        symbolLabel.text = "\(element.symbol)(\(element.number))  \(element.atomic_mass)"
        
        let elementId = String(format:"%03d", element.number)
        
        
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(elementId)/s7.JPG"
        
        
        elementImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("error\(appError)")
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.elementImage.image = image
                }
            }
        }
    }
    
}

