//
//  DetailViewController.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boilLabel: UILabel!
    @IBOutlet weak var meltLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var discoveredLabel: UILabel!
    
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElementInfo()

    }
    
    
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           elementImage.layer.cornerRadius = elementImage.frame.width/20
       }
    
    func loadElementInfo(){
        guard let element = element else {
            fatalError("check prepare for segue")
        }
        
        nameLabel.text = element.name
        numberLabel.text = element.number.description
        weightLabel.text = element.atomic_mass.description
        boilLabel.text = element.boil?.description
        meltLabel.text = element.melt?.description
        summaryLabel.text = element.summary
        discoveredLabel.text = element.discovered_by
        
        // get image

        let imageURL = "https://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        elementImage.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "exclamationmark.square")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
        
    }
    


}
