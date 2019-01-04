//
//  ElementDetailsController.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailsController: UIViewController {
  public var element: Element!
  
  @IBOutlet weak var elementImageView: UIImageView!
  @IBOutlet weak var elementSymbolLabel: UILabel!
  @IBOutlet weak var elementWeightLabel: UILabel!
  @IBOutlet weak var elementNumberLabel: UILabel!
  @IBOutlet weak var elementDiscoveryLabel: UILabel!
  @IBOutlet weak var elementBoilLabel: UILabel!
  @IBOutlet weak var elementMeltLabel: UILabel!
  private func loadImage() {
    let url = "http://www.theodoregray.com/periodictable/Tiles/\(element.elementNumber)/s7.JPG"
    ImageHelper.fetch(urlString: url) { (error, image) in
      if let error = error {
        self.elementImageView.image = UIImage(named: "placeholder")
      }
      
      if let image = image {
        self.elementImageView.image = image
      }
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = element.name
        loadImage()
        setupLabels()
        // Do any additional setup after loading the view.
    }
  private func unwrapMessage(text:String?,
                             prefix:String = "",
                             suffix:String = "") -> String{
    if var newText = text {
      return "\(prefix) \(newText) \(suffix)"
    }
    return ""
  }
  
  private func setupLabels(){
    elementWeightLabel.text = "Weight: \(String(format: "%.2f", element.atomic_mass))"
    elementSymbolLabel.text = element.symbol
    elementNumberLabel.text = String(element.number)
    elementDiscoveryLabel.text = unwrapMessage(text: element.discovered_by,
                                               prefix:"Discovered By:")
    if let melt = element.melt {
      elementBoilLabel.text = String(format: "%.2f", melt)
    }
    
    if let boil = element.boil {
        elementBoilLabel.text = String(format: "%.2f", boil)
    }
    
  }
  
  @IBAction func onFavoriteElement(_ sender: UIBarButtonItem) {
    let favoriteElement = FavoriteElement.init(favoritedBy: "Jevon"
      , elementName: element.name, elementSymbol: element.symbol)
    
    do {
      let encodedFavorite = try  JSONEncoder().encode(favoriteElement)
      ElementAPIClient.postFavoriteElement(favoriteElement: encodedFavorite) { (error, responseCode, success) in
        if let error = error {
          let errorVC = UIAlertController.errorController(error: error)
          self.present(errorVC, animated: true, completion: nil)
        }
        if let statusCode = responseCode {
          print("http response code: \(statusCode), post passed \(success)")
        }
      }
    } catch {
      let errorVC = UIAlertController.errorController(error: AppError.decodingError(error))
      self.present(errorVC, animated: true, completion: nil)
    }
    
    
  }
  
}
