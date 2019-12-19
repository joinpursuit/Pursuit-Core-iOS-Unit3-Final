//
//  DetailViewController.swift
//  Elements
//
//  Created by Tanya Burke on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

  
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
     
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadDetails()
        
    }

    
    func loadDetails(){
        guard let element = element else{
            fatalError("unable to access passed information")
        }
        navigationItem.title = "\(element.name)"
        detailLabel.text = "Symbol: \(element.symbol)\nNumber: \(element.number)\nWeight: \(element.atomicMass)\nMelting Point: \(element.melt)\nBoilingPoint: \(element.boil)\nDiscovered By: \(element.discoveredBy)"
        
      
        
        let fullImageUrl = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        elementImage.getImage(with: fullImageUrl) {[weak self] (result) in
                switch result{
                case .failure:
                    DispatchQueue.main.sync{
                        self?.elementImage.image = UIImage(systemName: "exclamationmark.triangle")
                        
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.elementImage.image = image
                        
                    }
                }
                
            }
        }
    
    
    @IBAction func favoriteAddButton(_ sender: Any) {

        let favElememnt = Element(name: element?.name ?? "",
                                  appearance: element?.appearance ?? "",
                                  atomicMass: element?.atomicMass ?? 0.0,
                                  boil: element?.boil ?? 0.0,
                                  category: element?.category ?? "",
                                  density: element?.density ?? 0.0,
                                  discoveredBy: element?.discoveredBy ?? "",
                                  melt: element?.melt ?? 0.0,
                                  namedBy: element?.namedBy ?? "",
                                  number: element?.number ?? 0,
                                  period: element?.period ?? 0,
                                  phase: element?.phase ?? "",
                                  source: element?.source ?? "",
                                  spectralImg: element?.spectralImg,
                                  symbol: element?.symbol ?? "",
                                  summary: element?.summary ?? "",
                                  id: element?.id,
                                  favoritedBy: "Tanya")
        
        ElementAPICLient.postFavorite(favorite: favElememnt) { [weak self](result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Error", message: "Unable to add to favorites\(appError)")
                }
            case .success:
                DispatchQueue.main.async{
                    self?.showAlert(title: "Success", message: "Added to favorites")
                }
            }
        }
    }
    
    }
    
    

