//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    searchElement()
    tableView.dataSource = self
  }
    
    private func searchElement() {
        ElementAPIClient.searchElement(keyword: "element") { (appError, element) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let element = element {
                print("\(element.count)")
                self.elements = element
            }
        }
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let theElement = elements[indexPath.row]
        cell.textLabel?.text = theElement.name
        return cell
    }
}
