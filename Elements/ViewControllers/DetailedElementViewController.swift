//
//  DetailedViewController.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailedElementViewController: UIViewController {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveredLabel: UILabel!
    @IBOutlet weak var fullImageView: UIImageView!
    
    var currentElement: Element?
    var enableOrDisable: Bool?
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()
    }
    
    private func viewWillSetUp(){
        if let _ = enableOrDisable{
            navigationItem.rightBarButtonItem?.isEnabled = false
            setUp()
        } else {
            setUp()
        }
    }
    
    private func setUp(){
        var endpointURL = ""
        if let name = currentElement?.name {
            navigationItem.title = name
            endpointURL = "http://images-of-elements.com/\(name.lowercased()).jpg"
        } else {
            navigationItem.title = "Unknown Element"
        }
        
        if let symbol = currentElement?.symbol {
            symbolLabel.text = "Symbol: \(symbol)"
        } else {
            symbolLabel.text = "Symbol: Unknown "
        }
        
        if let number = currentElement?.number{
            numberLabel.text = "Number: \(number)"
        } else {
            numberLabel.text = "Number: Unknown"
        }
        
        if let weight = currentElement?.atomicMass {
            weightLabel.text = "Mass: \(String(format: "%.3f", weight))"
        } else {
            weightLabel.text = "Mass: Unknown"
        }
        
        if let mPoint = currentElement?.melt {
            meltingPointLabel.text = "Melting Point: \(String(format: "%.3f", mPoint))"
        } else {
            meltingPointLabel.text = "Melting Point: Unknown"
        }
        
        if let bPoint = currentElement?.boil {
            boilingPointLabel.text = "Boiling Point: \(String(format: "%.3f", bPoint))"
        } else {
            boilingPointLabel.text = "Boiling Point: Unknown"
        }
        
        if let discover = currentElement?.discoveredBy {
            discoveredLabel.text = "Discovered By: \(discover)"
        } else {
            discoveredLabel.text = "Discovered By: Unknown"
        }
        
        fullImageView.getImage(endpointURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Image Error", "\(netError)")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    self?.fullImageView.image = image
                }
            }
        }
    }
    
    @IBAction func favourited(_ sender: UIBarButtonItem){
        sender.isEnabled = false
        guard var curElement = currentElement else{
            sender.isEnabled = true
            showAlert("Unwrapping Error", "Found a nil value when unwrapping variable of type Element")
            return
        }
        
        curElement.favouritedBy = "Cameron Rivera"
        ElementAPI.postElement(curElement) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    sender.isEnabled = true
                    self?.showAlert("Post Error", "Could not successfully favourite current element. Error: \(netError)")
                }
            case .success:
                DispatchQueue.main.async{
                    self?.showAlert("Post Successful", "Element was successfully favourited.")
                }
            }
        }
    }

}
