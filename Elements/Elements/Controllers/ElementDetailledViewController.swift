//
//  ElementDetailledViewController.swift
//  Elements
//
//  Created by Ashli Rankin on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailledViewController: UIViewController {

  @IBOutlet weak var elementImage: UIImageView!
  @IBOutlet weak var elementName: UILabel!
  @IBOutlet weak var elementNumber: UILabel!
  @IBOutlet weak var elementWeight: UILabel!
  @IBOutlet weak var meltingPoint: UILabel!
  @IBOutlet weak var boilingPoint: UILabel!
  @IBOutlet weak var discoveredBy: UILabel!
  @IBOutlet weak var favoriteButton: UIBarButtonItem!
  
  var element: Element?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpUi()
      title = element?.name
    }
  private func getTheImages(urlString:String,imageView:UIImageView){
    ImageHelper.shared.fetchImage(urlString: urlString) { (error, image) in
      if let error = error{
        print(error.errorMessage())
      }
      if let image = image {
          imageView.image = image
        
      }
    }
  }
  private func setUpAlertControl(title:String,message:String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  private func setUpUi(){
    guard let element = element else {return}
    let urlString = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
    getTheImages(urlString: urlString, imageView: self.elementImage)
    meltingPointAndBoilingPoint(elementProperty: element.melt, label: self.meltingPoint, propertyName: "Melting Point")
    meltingPointAndBoilingPoint(elementProperty: element.boil, label: self.boilingPoint, propertyName: "Boiling Point")
    elementName.text = " Symbol: \(element.symbol.capitalized)"
    elementNumber.text = "Atomic Number: \(element.number)"
    elementWeight.text = "Atomic Mass: \(element.atomic_mass)"
    discoveredBy.text = "Discovered By: \(element.discovered_by!.capitalized)"
  }
  @IBAction func addFavorite(_ sender: UIBarButtonItem) {
    guard let element = element else {return}
    let favorite = ElementEncoded.init(favoritedBy: "Ashli Rankin", elementName: element.name, elementSymbol: element.symbol)
    do {
      let data = try JSONEncoder().encode(favorite)
      ElementApiClient.sendFavorite(data: data) { (error, sucess) in
        if let error = error {
          DispatchQueue.main.async {
            self.setUpAlertControl(title: "Error", message: error.errorMessage())
          }
          
        } else if sucess {
          DispatchQueue.main.async{
          self.setUpAlertControl(title: "Sucess", message: "Sucessfully Favorited Element!!")
        }
        }
        else {
          DispatchQueue.main.async {
            self.setUpAlertControl(title: "No Go", message: "Was not favorited!!")
        }
      }
    }
    }
     catch {
      print("Encoding Error: \(error)")
      }
    }
  }
  
  func meltingPointAndBoilingPoint(elementProperty:Double?,label:UILabel,propertyName:String) {
    if let elementProperty = elementProperty {
      label.text = "\(propertyName): \(elementProperty)"
    } else {
      label.text = "No known value"
    }
  
}

