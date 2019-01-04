//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var titleElementName: UILabel!
    @IBOutlet weak var elementPhase: UILabel!
    @IBOutlet weak var elementDescription: UITextView!
    
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementNum: UILabel!
    @IBOutlet weak var elementSymbol: UILabel!
    @IBOutlet weak var elementAtomicWeight: UILabel!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = element.name
        
        updateDetailUI()
        setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = image
                backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
                self.view.insertSubview(backgroundImage, at: 0)
            }
        }
    }
    
    private func updateDetailUI() {
        titleElementName.text = element.name
        elementPhase.text = element.phase
        elementDescription.text = element.summary
        
        elementName.text = element.name
        elementNum.text = element.number.description
        elementSymbol.text = element.symbol
        elementAtomicWeight.text = element.atomicMass.description
    }
    
    
    @IBAction func addToFavorite(_ sender: UIBarButtonItem) {
        //set body
        let favorite = Favorite.init(favoritedBy: "Jian Ting", elementName: element.name, elementSymbol: element.symbol)
        
        //do (set data & call APIClient) & catch (encoding error)
        do {
            let data = try JSONEncoder().encode(favorite)
            
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if success {
                    print("successfully favorited podcast")
                } else {
                    print("was not favorited")
                }
            } 
        } catch {
            print("encoding error: \(error)")
        }
    }
    
}
