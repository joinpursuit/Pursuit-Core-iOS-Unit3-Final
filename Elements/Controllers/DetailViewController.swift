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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var atomicWeightLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
    public var selectedElement: Element!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        title = selectedElement.name
        nameLabel.text = selectedElement.name
        symbolLabel.text = "Symbol: \(selectedElement.symbol)"
        atomicWeightLabel.text = "Atomic Weight: \(selectedElement.atomic_mass)"
        sodiumLabel.text = "Sodium: \(selectedElement.boil ?? 0)"
        textView.text = selectedElement.summary
    }
    
    func setImage() {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(selectedElement.name.lowercased()).jpg")  { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.imageView.image = image
                }
            }
        }
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(elementName: selectedElement.name, favoritedBy: "Jose Carlos", elementSymbol: selectedElement.symbol)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success{
                    print("Successfuly element")
                } else {
                    print("Not element here")
                }
            }
        } catch {
            print("error is: \(error)")
        }
    }
}
