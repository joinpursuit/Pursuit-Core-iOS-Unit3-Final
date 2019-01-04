//
//  DetailedElementsVC.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedElementsVC: UIViewController {

  public var elementsForDeatiled: Elements!
  
  @IBOutlet weak var imageDetailed: UIImageView!
  
  @IBOutlet weak var discovery: UILabel!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      discovery.text = elementsForDeatiled.name
    }
    

  

}
