//
//  ElementCell.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

  @IBOutlet weak var elementImageView: UIImageView!
  @IBOutlet weak var elementNameLabel: UILabel!
  @IBOutlet weak var elementDetailsLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
