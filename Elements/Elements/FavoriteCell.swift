//
//  FavoriteCell.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

   
    @IBOutlet weak var favoriteImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    func configureCell(for element: ElementInfo) {
        nameLabel.text = element.name
        symbolLabel.text = "\(element.symbol)(\(element.number))  \(element.atomic_mass)"
        
        let elementId = String(format:"%03d", element.number)
        
        
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(elementId)/s7.JPG"
        
        
        favoriteImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("error\(appError)")
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.favoriteImage.image = image
                }
            }
        }
    }

}
