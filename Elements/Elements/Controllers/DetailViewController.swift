//
//  DetailViewController.swift
//  Elements
//
//  Created by Aaron Cabreja on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var element: Element!

    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var discoverdByLabel: UILabel!
    @IBOutlet weak var boilLabel: UILabel!
    
    @IBOutlet weak var meltLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
     
        
        updateUI()
        // Do any additional setup after loading the view.
    }
    private func updateUI(){
        numberLabel?.text = "Number: \(element.number)"
        symbolLabel?.text = "Symbol: \(String(describing: element.symbol))"
        weightLabel.text = "Atomic Mass: \(String(describing: element.atomicMass))"
        if let  boiling = element.boil{
            boilLabel?.text = "Boiling Point: \(String(describing: boiling))"
        } else {
            boilLabel?.text = "Boiling Point not found"
        }
        if let melting = element.melt {
            meltLabel?.text = "Melting Point: \(String(describing: melting))"

        } else {
            meltLabel?.text = "Melting Point not found"
        }
        if let discovered = element.discoveredBy {
            
        discoverdByLabel?.text = "Discovered By: \(String(describing: discovered))"
        } else {
            discoverdByLabel?.text = "Discovered By not found"
        }
        let elementName = element.name?.lowercased()
        let urlString = "http://images-of-elements.com/\(elementName!).jpg"
        if let image = ImageHelper.shared.image(forKey: urlString as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
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
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        let favorite = Favorite.init(elementName: element.name!, favoritedBy: "Aaron Cabreja", elementSymbol: element.symbol)
        // encode the favorite object as Data to send to the API
        // using JSONEncoder()
        do {
            let data = try JSONEncoder().encode(favorite)
            APIClient.favoritePodcast(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully favorited podcast", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
    

}
