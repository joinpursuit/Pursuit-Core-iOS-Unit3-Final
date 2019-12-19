//
//  ElementCell.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func prepareForReuse() {
        elementImageView.image = nil
    }
}
