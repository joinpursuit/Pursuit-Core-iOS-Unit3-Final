//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
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
    tableView.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let elementDVC = segue.destination as? ElementsDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("error")
        }
        
        let elements = element[indexPath.row]
        elementDVC.element = elements
    }


}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return element.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("error")
        }
        let elements = element[indexPath.row]
        cell.configured(for: elements)
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
