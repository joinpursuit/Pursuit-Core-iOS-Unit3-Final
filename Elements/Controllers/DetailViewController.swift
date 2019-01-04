//
//  DetailViewController.swift
//  Elements
//
//  Created by Jose Alarcon Chacon on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
  public var selectedElement: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedElement.name
        
        
        
    }
    func setImage() {
       
    }

}
