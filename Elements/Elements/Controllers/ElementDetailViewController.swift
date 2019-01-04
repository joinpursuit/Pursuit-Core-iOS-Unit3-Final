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
        
        //***set image here
        //if image is available, do this
        //otherwise set background color black
        
        /*
         UIGraphicsBeginImageContext(self.view.frame.size);
         [[UIImage imageNamed:@"image.png"] drawInRect:self.view.bounds];
         UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         
         self.view.backgroundColor = [UIColor colorWithPatternImage:image];
         */
    }
    
    func updateDetailUI() {
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
