//
//  ElementTableViewCell.swift
//  Elements
//
//  Created by Pritesh Nadiadhara on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementIMG: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementSymAndWeight: UILabel!
    
    static func getImage(stringURL: String) -> UIImage? {
        guard let myImageURL = URL.init(string: stringURL) else {return nil}
        do {
            let data = try Data.init(contentsOf: myImageURL)
            guard let image = UIImage.init(data: data) else {return nil}
            return image
        }catch{
            print(error)
            return nil
        }
    }
    
}

