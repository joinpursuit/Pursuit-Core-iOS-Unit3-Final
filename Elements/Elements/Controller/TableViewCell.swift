//
//  TableViewCell.swift
//  Elements
//
//  Created by Biron Su on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolNumWeight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
