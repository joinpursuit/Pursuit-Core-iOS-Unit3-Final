//
//  ElementCell.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementDetailLabel: UILabel!
    
    func configureCell(element: Element) {
        elementNameLabel.text = element.name
        elementDetailLabel.text = "\(element.symbol) (\(element.number)) - \(element.atomic_mass)"
        elementImage.getImage(with: "http://www.theodoregray.com/periodictable/Tiles/\(element.numberForURLConverter())/s7.JPG", completion: { [weak self] (result) in
            switch (result) {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "xmark.icloud")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        })
    }
}
