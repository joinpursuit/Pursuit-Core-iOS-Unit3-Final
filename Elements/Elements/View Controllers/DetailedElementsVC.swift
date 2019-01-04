//
//  DetailedElementsVC.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedElementsVC: UIViewController {
  
  public var elementsForDeatiled: Elements!
  @IBOutlet weak var favoriteButton: UIBarButtonItem!
  
  @IBOutlet weak var imageDetailed: UIImageView!
  
  @IBOutlet weak var discovery: UILabel!
  
  @IBOutlet weak var number: UILabel!
  
  @IBOutlet weak var symbol: UILabel!
  
  @IBOutlet weak var atomicMass: UILabel!
  
  @IBOutlet weak var meltingpPoint: UILabel!
  
  @IBOutlet weak var boilingPoint: UILabel!
  
  @IBOutlet weak var nameForDetailed: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = elementsForDeatiled.name
    UpdateUI(imageKey: elementsForDeatiled.name.lowercased())
  }
  
  private func UpdateUI(imageKey: String){
    
    ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(imageKey).jpg") { (appError, image) in
      if let appError = appError {
        print(appError.errorMessage())
        DispatchQueue.main.async {
          self.imageDetailed.image = UIImage.init(named: "placeholderImage")
        }
        
      } else if let image = image {
        self.imageDetailed.image = image
      }
    }
    number.text = "\( elementsForDeatiled.number)"
    symbol.text = elementsForDeatiled.symbol
    atomicMass.text = "Relative Atomic Mass: \(elementsForDeatiled.atomic_mass)"
    
    nameForDetailed.text = elementsForDeatiled.name
    
    if let discoveredBy = elementsForDeatiled.discovered_by{
      discovery.text = "Discovered by: " + discoveredBy
    } else {
      discovery.text = "Discovered by: Unknown"
    }
    
    
    if let meltingPoint = elementsForDeatiled.melt{
      meltingpPoint.text = "Melting point: " + String(meltingPoint)
    } else {
      meltingpPoint.text = "Melting point: consult further"
    }
    if let boilPoint = elementsForDeatiled.boil{
      boilingPoint.text = "Boiling point: " + String(boilPoint)
    } else {
      boilingPoint.text = "Boiling Point: consult further"
      
    }
    
  }
  
  private func showAlert(title: String, message: String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
    alertController.addAction(okAction)
    present(alertController, animated:  true, completion: nil)
  }
  
  
  
  @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
    let favorite = Favorite.init(favoritedBy: "Eli Peraza", elementName: elementsForDeatiled.name, elementSymbol: elementsForDeatiled.symbol)
    
    do {
      let data = try JSONEncoder().encode(favorite)
      ElementAPIClient.favoriteElement(data: data) { (appError, success) in
        if let appError = appError {
          DispatchQueue.main.async {
            self.showAlert(title: "Error Message", message: appError.errorMessage())
          }
        } else if success {
          DispatchQueue.main.async {
            self.showAlert(title: "Title was marked as favorite", message: "")
          }
        }
      }
    } catch {
      print("encoding error: \(error)")
    }
  }
  
  
}
