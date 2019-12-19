//
//  DetailViewController.swift
//  Elements
//
//  Created by Yuliia Engman on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageOfElement: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var discoveredbyLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var oneElement: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let oneElement = oneElement else {
            fatalError("could not get object from prepare for segue")
        }
        navigationItem.title = oneElement.name
        symbolLabel.text = oneElement.symbol
        numberLabel.text = String(oneElement.number)
        weightLabel.text = String(oneElement.atomicMass)
        meltingLabel.text = String(oneElement.melt ?? 0)
        boilingLabel.text = String(oneElement.boil ?? 0)
        
        let bigImageURL = "https://images-of-elements.com/\(oneElement.name.lowercased()).jpg"
        
        imageOfElement.getImage(with: bigImageURL) {[weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageOfElement.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let elementImage):
                DispatchQueue.main.async {
                    self?.imageOfElement.image = elementImage
                }
            }
            
        }
    }
}
