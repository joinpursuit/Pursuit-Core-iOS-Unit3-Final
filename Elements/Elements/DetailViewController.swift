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
        weightLabel.text = "Atomic weight: " + String(oneElement.atomicMass)
        meltingLabel.text = "Melting temperature:\n" + String(oneElement.melt ?? 0)
        boilingLabel.text = "Boiling temperature:\n" + String(oneElement.boil ?? 0)
        discoveredbyLabel.text = "Descovered by \(oneElement.discoveredBy ?? "")"
        
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
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        guard let someElement = oneElement else {
            fatalError("error")
        }
        let elementPost = Element(name: someElement.name, appearance: someElement.appearance, atomicMass: someElement.atomicMass, boil: someElement.boil, category: someElement.category, color: someElement.color, density: someElement.density, discoveredBy: someElement.discoveredBy, melt: someElement.melt, molarHeat: someElement.molarHeat, namedBy: someElement.namedBy, number: someElement.number, period: someElement.period, phase: someElement.phase.self, source: someElement.source, spectralImg: someElement.spectralImg, summary: someElement.summary, symbol: someElement.symbol, favoritedBy: "Yuliia")
        
        ElementAPIClient.postFavoriteElement(favoriteElement: elementPost) {[weak self, weak sender] result in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to post element", message: "\(appError)")
                    sender?.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite Element Added", message: "") {
                        alert in
                        self?.dismiss(animated: true)
                    }
                }
            }
            
        }
    }
    
}
