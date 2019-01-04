//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    
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
        uploadData()
    }
    private func uploadData() {
        ElementAPIClient.getAllElements { (appError, element) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let element = element {
                self.elements = element
            }
        }
    }
    
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = elementTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementViewCell else { return UITableViewCell() }
        let elementToSet = elements[indexPath.row]
        cell.elementName.text = elementToSet.name
        cell.atomicWeight.text = "Atomic Weight: \(elementToSet.atomicMass)"
        return cell
    }
    
    
}
