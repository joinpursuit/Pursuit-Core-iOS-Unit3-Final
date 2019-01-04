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
    private var elements = [Element]() {
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
        let backButton = UIBarButtonItem()
        backButton.title = "Elements"
        navigationItem.backBarButtonItem = backButton
    loadData()
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let elementDetailController = segue.destination as? DetailViewController else { fatalError("indexPath, DetailViewController nil")}
        let element = elements[indexPath.row]
        elementDetailController.element = element
    }
    func loadData() {
        APIClient.getElements { (error, element) in
            if let error = error {
                print(error.errorMessage())
            } else if let element = element {
                self.elements = element
            }
        }
    }

}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {
            fatalError("ElementCell error")
        }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

