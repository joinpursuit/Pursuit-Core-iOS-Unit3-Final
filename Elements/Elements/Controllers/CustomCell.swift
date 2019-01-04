//
//  CustomCell.swift
//  Elements
//
//  Created by Ian Bailey on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
    @IBOutlet weak var CustomName: UILabel!
    @IBOutlet weak var CustomNumberMass: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
