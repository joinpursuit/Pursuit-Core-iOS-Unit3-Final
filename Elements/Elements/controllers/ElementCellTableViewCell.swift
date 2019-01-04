//
//  ElementCellTableViewCell.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCellTableViewCell: UITableViewCell {
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementDescription: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
