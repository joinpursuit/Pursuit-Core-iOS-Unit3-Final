//
//  DetailElementVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementVC: UIViewController {

    public var element: Element!
    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var meltingPoint: UILabel!
    @IBOutlet weak var boilingPoint: UILabel!
    @IBOutlet weak var discoveryBy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
    }
}
