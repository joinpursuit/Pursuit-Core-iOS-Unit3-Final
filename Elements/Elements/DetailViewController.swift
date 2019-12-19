//
//  DetailViewController.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementDetailLabel: UILabel!
    @IBOutlet weak var meltBoilLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    
    var element: Element?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let detailVCElement = element else {
            fatalError("Error: Couldn't pull Element, check prepare for segue")
        }
        title = detailVCElement.name
        elementDetailLabel.text = "\(detailVCElement.symbol) (\(detailVCElement.number)) - \(detailVCElement.atomic_mass)"
        meltBoilLabel.text = "Melt Point: \(detailVCElement.melt ?? -0.1) - Boil Point: \(detailVCElement.boil ?? -0.1)"
        discoveredByLabel.text = "Discovered by " + (detailVCElement.discovered_by ?? "Unknown")
        elementImage.getImage(with: "http://images-of-elements.com/\(detailVCElement.name.lowercased()).jpg", completion: { [weak self] (result) in
            switch (result) {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "xmark.icloud")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        })
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        guard let detailVCElement = element else {
            fatalError("Error: Couldn't pull Element, check prepare for segue")
        }
        
        ElementAPIClient.postElement(element: Element(name: detailVCElement.name, symbol: detailVCElement.symbol, number: detailVCElement.number, atomic_mass: detailVCElement.atomic_mass, melt: detailVCElement.melt, boil: detailVCElement.boil, discovered_by: detailVCElement.discovered_by, favoritedBy: "Matthew Ramos"), completion: { [weak self, weak sender] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post Favorite", message: "\(appError)")
                    sender?.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite Posted", message: "Your favorite has been posted to favorites.")
                }
            }
            
        })
        
    }
}

