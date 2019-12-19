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

    var element = [Elements]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    loadElements()
    
  }
    
    func loadElements() {
        ElementsAPIClient.getElements { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let elements):
                self.element = elements
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return element.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        let elements = element[indexPath.row]
        cell.textLabel?.text = elements.name
        return cell
    }
}
