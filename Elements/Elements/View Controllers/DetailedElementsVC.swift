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
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      discovery.text = elementsForDeatiled.name
      title = elementsForDeatiled.name
    }
  
  private func UpdateUI(){
    
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
