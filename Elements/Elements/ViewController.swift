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
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        getElements()
        tableView.dataSource = self
        tableView.delegate = self
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error: Couldn't prepare segue")
        }
        detailVC.element = elements[indexPath.row]
    }
    
    func getElements() {
    ElementAPIClient.fetchElements(completion: { [weak self] (result) in
        switch result {
        case .failure(let appError):
            DispatchQueue.main.async {
                    self?.showAlert(title: "Error: Could not read data", message: "\(appError)")
                }
            case .success(let elements):
                    self?.elements = elements
                }
        }
    )
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("Couldn't access ElementCell")
        }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        207
    }
    
}
