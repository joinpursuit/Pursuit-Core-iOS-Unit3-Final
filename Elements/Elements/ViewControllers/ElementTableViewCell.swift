//
//  ElementTableViewCell.swift
//  Elements
//
//  Created by Donkemezuo Raymond Tariladou on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementAtomicNumber: UILabel!
    var elements: Elements!
    
    
    func fetchThumbImage (){
        let imageEndPoint = "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d",elements.number))/s7.JPG"
        ImageHelper.shared.fetchImage(urlString: imageEndPoint) { (appError, imageData) in
            if appError != nil {

            } else if let data = imageData {
                self.elementImage.image = data
            }
        }
    }
}
