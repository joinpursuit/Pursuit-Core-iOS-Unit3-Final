//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    @IBOutlet weak var ElementTable: UITableView!
    
    var elements = [ElementData]() {
    didSet {
        DispatchQueue.main.async {
            self.ElementTable.reloadData()
        }
    }
}
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    ElementTable.dataSource = self
    // Do any additional setup after loading the view, typically from a nib.
  }
    private func getData() {
        APIClient.loadData() { (error, elements) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = elements {
                self.elements = data
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = ElementTable.indexPathForSelectedRow,
        let eleDetailViewController = segue.destination as?
            ElementDetailViewController else {
                fatalError("failed")
        }
        let element = elements[indexPath.row]
        eleDetailViewController.element = element
    }
    
    
    
    

}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ElementTable.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        as! CustomCell
        let element = elements[indexPath.row]
        cell.CustomName?.text = "\(element.name)"
        cell.CustomNumberMass?.text = "\(element.symbol)(\(element.number)) \(element.atomicMass)"
        return cell
    }
}
