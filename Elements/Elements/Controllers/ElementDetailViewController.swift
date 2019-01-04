//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Alyson Abril on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    @IBOutlet weak var elementDetailImage: UIImageView!
    @IBOutlet weak var nameSymbolLabel: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var meltPoint: UILabel!
    @IBOutlet weak var boilPoint: UILabel!
    @IBOutlet weak var discoveredLabel: UILabel!
    
    
    public var element = Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update
    }
    func updateElementInfo () {
//        elementNameLabel.text =
//        userDobLabel.text = user.dob
//        userPhoneLabel.text = user.phone
//        userEmailLabel.text = user.email
//        userLocationLabel.text = user.location.fullLocation
//        do {
//            let imageData = try Data(contentsOf: user.picture.large)
//            userImageView.image = UIImage.init(data: imageData)
//        } catch {
//            print("Error: \(error)")
//        }
    }

}
