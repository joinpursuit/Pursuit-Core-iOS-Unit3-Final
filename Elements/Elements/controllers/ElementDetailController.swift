//
//  ElementDetailController.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailController: UIViewController {
    var element: Element!

    override func viewDidLoad() {
        super.viewDidLoad()
    title = element.name
    }

}
