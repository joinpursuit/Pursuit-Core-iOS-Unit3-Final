//
//  ElementCell.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    

    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementInfoLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        elementImage.layer.cornerRadius = elementImage.frame.width/13
    }
   
    func configureCell(for element: Element) {
        
        elementNameLabel.text = element.name
        elementInfoLabel.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        
       // get element Id
      
        var elementId = ""
        
        switch String(element.number).count {
        case 1:
            elementId = "00\(element.number)"
        case 2:
            elementId = "0\(element.number)"
        case 3:
            elementId = "\(element.number)"
        default:
            print("issue with image")
        }
        
        let imageUrl = "https://www.theodoregray.com/periodictable/Tiles/\(elementId)/s7.JPG"
        
         // get thumbnail image
        elementImage.getImage(with: imageUrl) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "exclamationmark.square")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
    }

}
