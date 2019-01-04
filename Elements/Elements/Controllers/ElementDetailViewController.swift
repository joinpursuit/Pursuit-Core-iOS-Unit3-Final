//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Ian Bailey on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var melting: UILabel!
    @IBOutlet weak var boiling: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    public var element: ElementData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        updateView()
    }
    
    func updateView() {
        symbol.text = "The Atomic symbol is \(element.symbol)"
        number.text = "Its number is \(element.number)"
        weight.text = "Its Weight is \(element.atomicMass)"
        if element.melt != nil {
        melting.text = "Its melting Point is \(element.melt!)"
        } else {
            melting.text = "The melting point is unknown"
        }
        if element.boil != nil {
        boiling.text = "Its boiling Point is \(element.boil!)"
        } else {
            boiling.text = "The Boiling point is unknown"
        }
        if element.discoveredBy != nil {
        discoveredBy.text = "It was discovered by \(element.discoveredBy!)"
        } else {
            discoveredBy.text = "Unsure of who discovered \(element.name)"
        }
    }
  
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let favoriteEle = FavoriteElements.init(elementName: element.name, favoritedBy: "IanBailey", elementSymbol: element.symbol )
        
        do {
            let data = try JSONEncoder().encode(favoriteEle)
            APIClient.uploadData(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success {
                        print("Success")
                }  else {
                            print("failure")
                        }
                    }
                } catch {
                    print ("encoding error: \(error)")
                }
            }
        }

    
    


