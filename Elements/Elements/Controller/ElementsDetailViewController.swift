//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by Kevin Waring on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    public var element: Element!
    var url = "http://www.theodoregray.com/periodictable/Tiles/001/s7.JPG"
    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementNumber: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    @IBOutlet weak var elementMelting: UILabel!
    @IBOutlet weak var elementBoiling: UILabel!
    @IBOutlet weak var discoverBy: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    private func updateUI() {
        
        elementSymbol.text = element.symbol
        elementNumber.text = "\(element.number)"
        elementWeight.text = "\(element.atomic_mass)"
        elementMelting.text = "\(element.melt)"
        elementBoiling.text = "\(element.boil)"
        discoverBy.text = "\(element.discovered_by)"
        
        if let discover = element.discovered_by{
            discoverBy.text = "\(discover)"
        }else{
            discoverBy.text =  "n/a"
        }
        if let boil = element.boil{
            elementBoiling.text = "\(boil)"
        }else{
            elementBoiling.text = "n/a"
        }
            if let melt = element.melt{
                elementMelting.text = "\(melt)"
            }else {
                elementMelting.text = "n/a"
                
    
        if let image = ImageHelper.shared.image(forKey: url as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: url) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
                }
            }
        }

}
}
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        let favorite = Post.init(name: element.name)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementsAPI.favoritePodcast(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "No go", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
}
