//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var elementTableView: UITableView!
    
    var elementData = [Elements]() {
        didSet {
            elementTableView.reloadData()
        }
    }
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    elementTableView.delegate = self
    elementTableView.dataSource = self
    loadData()
    // Do any additional setup after loading the view, typically from a nib.
  }
    func loadData (){
        ElementApiManager.shared.getElements { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let beerArrFromOnline):
                    self.elementData = beerArrFromOnline
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisElement = elementData[indexPath.row]
        let elementCell = elementTableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! ElementTableViewCell
        elementCell.elementNameLabel.text = thisElement.name
        elementCell.elementSymbol.text = "\(thisElement.symbol)(\(thisElement.number)) \(thisElement.atomic_mass)"
        return elementCell
    }
    

}

