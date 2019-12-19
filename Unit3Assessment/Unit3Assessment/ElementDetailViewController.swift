//
//  ElementDetailViewController.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var discoveryLabel: UILabel!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    var element: Element!
    
    private let name = "Ahad"
    
    private let endpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    
    private var favorites = [Favorite]() {
        didSet {
            if isFavorited {
                barButton.style = .done
                barButton.image = UIImage(systemName: "hand.thumbsup.fill")
            } else {
                barButton.style = .plain
                barButton.image = UIImage(systemName: "hand.thumbsup")
            }
        }
    }
    
    private var isFavorited: Bool {
        favorites.map{$0.name}.contains(element.name)
    }
    
    private var imageURL: String {
        "https://images-of-elements.com/\(element.name.lowercased()).jpg"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        loadData()
        configureView()
    }
    
    private func configureView() {
        symbolLabel.text = element.symbol
        numberLabel.text = "\(element.number)"
        massLabel.text = "\(element.atomicMass)"
        meltingLabel.text = element.melt != nil ? "\(element.melt!) K" : nil
        boilingLabel.text = element.boil != nil ? "\(element.boil!) K" : nil
        discoveryLabel.text = element.discoveredBy != nil ? element.discoveredBy : nil
        
        imageView.getImage(with: imageURL) { result in
            switch result {
            case .failure(let error):
                print("Error getting image: \(error)")
                DispatchQueue.main.async {
                self.imageView.image = UIImage(systemName: "cloud.rain")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private func loadData() {
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: endpointURL) { (result) in
            switch result {
            case .failure(let error):
                print("Error getting JSON from favorites: \(error)")
            case .success(let favoritesFromAPI):
                self.favorites = favoritesFromAPI.filter({$0.favoritedBy == self.name})
            }
        }
    }
    
    @IBAction func unwindToSomething(_ sender: UIStoryboardSegue) {}
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        switch sender.style {
        case .done:
            sender.isEnabled = false
            if isFavorited {
                let favorite = favorites.first { $0.name == element.name }
                if let favorite = favorite, let id = favorite.id {
                    GenericCoderService.manager.deleteJSON(with: endpointURL + "/\(id)") { (result) in
                        switch result {
                        case .failure(let error):
                            print("Error deleting JSON: \(error)")
                        case .success:
                            DispatchQueue.main.async {
                                sender.isEnabled = true
                                sender.style = .plain
                                sender.image = UIImage(systemName: "hand.thumbsup")
                            }
                        }
                    }
                }
            }
            
        case .plain:
            sender.isEnabled = false
            let favorite = Favorite(id: nil, category: element.category, melt: element.melt, boil: element.boil, period: element.period, symbol: element.symbol, discoveredBy: element.discoveredBy, molarHeat: element.molarHeat, phase: element.phase, source: element.source, summary: element.summary, favoritedBy: name, number: element.number, appearance: element.appearance, density: element.density, atomicMass: element.atomicMass, name: element.name)
            GenericCoderService.manager.postJSON(object: favorite, with: endpointURL) { (result) in
                switch result {
                case .failure(let error):
                    print("Error posting JSON: \(error)")
                    DispatchQueue.main.async {
                        sender.isEnabled = true
                        sender.style = .done
                        sender.image = UIImage(systemName: "hand.thumbsup.fill")
                    }
                case .success:
                    self.loadData()
                    DispatchQueue.main.async {
                        sender.isEnabled = true
                        sender.style = .done
                        sender.image = UIImage(systemName: "hand.thumbsup.fill")
                    }
                }
            }
        default:
            break
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
