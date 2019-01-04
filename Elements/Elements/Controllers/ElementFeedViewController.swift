//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementFeedViewController: UIViewController {
    
    
    @IBOutlet weak var elementTableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.elementTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementTableView.dataSource = self
        getElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementTableView.indexPathForSelectedRow,
            let elementDetailViewController = segue.destination as?ElementDetailViewController else {
                fatalError("indexPath, elementDVC nil")
        }
        let element = elements[indexPath.row]
        elementDetailViewController.element = element
    }
    
    @objc private func getElements() {
        ElementAPIClient.fetchElements { (appError, element) in
            if let  appError = appError {
                print(appError.errorMessage())
            } else if let element = element {
                self.elements = element
            }
        }
    }
}


extension ElementFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else { fatalError("element cell not found") }
        
        let element = elements[indexPath.row]
        //cell.elementImage.image = element.image
        cell.elementName.text = element.name
        cell.elementDetailLabel.text = String("\(element.symbol)" + " " + "\(element.atomicMass)")
        return cell
    }
}
