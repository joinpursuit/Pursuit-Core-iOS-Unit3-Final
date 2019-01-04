//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    var element: Element!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
    }


}
