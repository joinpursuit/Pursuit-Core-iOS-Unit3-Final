//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var elements = [Elements]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    getElements()
  }
    private func getElements() {
        ElementAPIClient.getElements { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.elements = elements
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow, let secondVC = segue.destination as? SecondViewController else {return}
        let element = elements[indexPath.row]
        secondVC.element = element
    }
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? TableViewCell else {return TableViewCell()}
        let cellToSet = elements[indexPath.row]
        cell.nameLabel.text = cellToSet.name.capitalized
        cell.symbolNumWeight.text = "\(cellToSet.symbol)(\(cellToSet.number)) \(cellToSet.atomic_mass)"
        DispatchQueue.main.async {
            if let url = URL(string: "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d",cellToSet.number))/s7.JPG") {
                ImageHelper.shared.fetchImage(urlString: url.absoluteString) { (appError, image) in
                    if let appError = appError {
                        print("Image Error \(appError)")
                    } else if let image = image {
                        cell.elementImage.image = image
                    }
                }
            }
        }
        return cell
    }
}
