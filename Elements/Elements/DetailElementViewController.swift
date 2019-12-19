//
//  DetailElementViewController.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementViewController: UIViewController {
    
    
    @IBOutlet weak var elementImage: UIImageView!
    
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    
    @IBOutlet weak var boilingLabel: UILabel!
    
    
    @IBOutlet weak var meltingLabel: UILabel!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    var elementInfo: ElementInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        
    }
    
    func updateUI() {
        guard let element = elementInfo else {
            fatalError("check prepwre for segue")
        }
        
        navigationItem.title = element.name
        
        symbolLabel.text = element.symbol
        numberLabel.text = element.number.description
        discoveredByLabel.text = "Discobered by: \(element.discovered_by ?? "")"
        boilingLabel.text = element.boil?.description
        meltingLabel.text = element.melt?.description
        weightLabel.text = element.atomic_mass.description
        
        let imageURL = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        elementImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("error\(appError)")
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.elementImage.image = image
                }
            }
        }
        
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        guard let element = elementInfo else {
            fatalError("error")
        }
        
        let elementPost = ElementInfo(name: element.name, atomic_mass: element.atomic_mass, discovered_by: element.discovered_by, melt: element.melt, number: element.number, phase: element.phase, symbol: element.symbol, boil: element.boil, favoritedBy: "Luba")
        
        ElementAPIClient.postElement(element: elementPost) { [weak self, weak sender] (result) in
            DispatchQueue.main.async {
              sender?.isEnabled = true
            }
            switch result {
            case .failure(let appError):
              DispatchQueue.main.async {
                self?.showAlert(title: "Error posting podcast", message: "\(appError)")
              }
            case .success:
              DispatchQueue.main.async {
                self?.showAlert(title: "Success", message: "Element was posted") { action in
                  self?.dismiss(animated: true)
                }
              }
            }
        }
    }
    
    
    
}
