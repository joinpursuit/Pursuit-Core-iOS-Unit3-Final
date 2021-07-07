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
    
   private var urlString = ""
    
    func configureCell(for element: ElementInfo) {
        nameLabel.text = element.name
        symbolLabel.text = "\(element.symbol)(\(element.number))  \(element.atomic_mass ?? 0)"
        
        let elementId = String(format:"%03d", element.number)
        
        
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(elementId)/s7.JPG"
        
        urlString = imageURL
        
        elementImage.getImage(with: imageURL) { [weak self](result) in
            switch result {
         case .failure:
//                print("error\(appError)")
                DispatchQueue.main.async {
                  self?.elementImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.urlString == imageURL {
                    self?.elementImage.image = image
                }
                }
            }
        }
    }
    override func prepareForReuse() {
      super.prepareForReuse()
      elementImage.image = UIImage(systemName: "mic.fill")
    }
    
}

