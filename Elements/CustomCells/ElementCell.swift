//
//  ElementCell.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
// Thrown error
enum SetUpError: Error{
    case missingFields
}

class ElementCell: UITableViewCell{
    
    // MARK: Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    // MARK: Properties
    var imageURL = ""
    
    // MARK: Lifecycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage.image = nil
    }
    
    // MARK: Helper Functions
    func setUp(_ element: Element) throws{
        
        if let name = element.name {
            elementNameLabel.text = name
        } else {
            elementNameLabel.isHidden = true
        }
        
        if let weight = element.atomicMass,
           let symbol = element.symbol,
           let number = element.number {
            moreInfoLabel.text = "\(symbol) (\(number))  \(String(format: "%.3f", weight))"
        } else {
            moreInfoLabel.isHidden = true
            throw SetUpError.missingFields
        }
        
        guard let number = element.number else {
            throw SetUpError.missingFields
        }
        
        let thumbnailEndpoint = "http://www.theodoregray.com/periodictable/Tiles/\(makeItThreeNumbers(number))/s7.JPG"
        imageURL = thumbnailEndpoint
        thumbnailImage.getImage(thumbnailEndpoint) { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Error: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    if self?.imageURL == thumbnailEndpoint{
                        self?.thumbnailImage.image = image
                    }
                }
            }
        }
        
    }
    
    private func makeItThreeNumbers(_ eNumber: Int) -> String{
        var tempString = eNumber.description
        
        while tempString.count < 3{
            tempString.insert("0", at: tempString.startIndex)
        }
        
        return tempString
    }
}
