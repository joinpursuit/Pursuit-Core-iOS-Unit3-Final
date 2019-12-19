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
    
    var elements = [ElementInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    loadData()
    tableView.delegate = self
  }

    func loadData() {
        ElementAPIClient.fetchElements { [weak self](result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let elements):
                self?.elements = elements
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailElementVC = segue.destination as? DetailElementViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let elementInfo = elements[indexPath.row]
        detailElementVC.elementInfo = elementInfo
    }

}

extension ElementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("could not dequeue elementCell")
        }
        let element = elements[indexPath.row]
        cell.configureCell(for: element)
        cell.backgroundColor = .systemGray
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
