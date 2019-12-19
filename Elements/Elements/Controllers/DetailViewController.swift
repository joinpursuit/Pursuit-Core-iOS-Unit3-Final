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
    
    @IBOutlet weak var favoriteButton: UIButton!
    
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
        numberLabel.text = "🔢 Atomic Number: \(element.number)"
        weightLabel.text = "🏋🏽‍♀️ Atomic Mass: \(element.atomic_mass)"
        boilLabel.text = "♨ Boiling Point: \(element.boil ?? 0.0)"
        meltLabel.text = "💧Melting Point: \(element.melt ?? 0.0)"
        summaryLabel.text = element.summary
        discoveredLabel.text = "💡Discovered by: \(element.discovered_by ?? "N/A")"
        
        // get image
        
        let imageURL = "https://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        elementImage.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "cube")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
        
        if element.favoritedBy != nil {
            let bookmarkImage = UIImage(systemName: "bookmark.fill")
            favoriteButton.setImage(bookmarkImage, for: .normal)
            favoriteButton.isEnabled = false
        }
        
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        let bookmarkImage = UIImage(systemName: "bookmark.fill")
        favoriteButton.setImage(bookmarkImage, for: .normal)
        sender.isEnabled = false
        
        guard let element = element else {
            fatalError("check prepare for segue")
        }
        
        // create instance of element to be posted as a favorite
        
        let favoritedElement = Element(name: element.name, discovered_by: element.discovered_by, number: element.number, melt: element.melt, symbol: element.symbol, summary: element.summary, boil: element.boil, atomic_mass: element.atomic_mass, favoritedBy: "Ameni A.")
        
        ElementAPIClient.postFavorite(favoritedElement: favoritedElement) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to post answer", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "♥️ + 🧪", message: "\(element.name) have been added to Favorites")
                }
            }
        }
    }
}





