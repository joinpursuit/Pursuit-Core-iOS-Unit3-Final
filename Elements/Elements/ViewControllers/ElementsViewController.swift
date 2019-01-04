//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    @IBOutlet weak var elementTableView: UITableView!
    
   private var periodicTableElements = [Elements](){
    didSet {
        DispatchQueue.main.async {
            self.elementTableView.reloadData()
            self.title = "Periodic Table"
            
        }
    }
        
    }
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    elementTableView.dataSource = self
    elementTableView.delegate = self
    fetchPeriodicTableElements()
//    fetchImage()
   
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let elementIndexPath = elementTableView.indexPathForSelectedRow, let details = segue.destination as? ElementDetailedViewController else {return}
        let element = periodicTableElements[elementIndexPath.row]
        details.elementInDetails = element
    }
    

    
    func fetchPeriodicTableElements(){
        
        PeriodicElementAPIClient.getElements { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements{
                self.periodicTableElements = elements
            }
        }
        
    }

}
extension ElementsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodicTableElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = elementTableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {return UITableViewCell()}
        let element = periodicTableElements[indexPath.row]
        cell.elementName.text = element.name
        cell.elements = element
        cell.fetchThumbImage()
        cell.elementAtomicNumber.text = "\(element.symbol) \(("\((element.number))")) \(element.atomic_mass)"

        return cell
    }
    
    
}

extension ElementsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
