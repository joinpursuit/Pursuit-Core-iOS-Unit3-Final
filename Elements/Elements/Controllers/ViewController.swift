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
    title = "Elements"
    tableView.dataSource = self
    tableView.delegate = self
    fetchElements()
  }
    private func fetchElements() {
        ElementAPIClient.getElements { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.elements = elements
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailViewController else {fatalError("Segue error")}
        let element = elements[indexPath.row]
        detailViewController.element = element
        
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {fatalError("ElementCell error")}
        let elementToSet = elements[indexPath.row]
        cell.elementName.text = elementToSet.name
        cell.elementSymbolAndWeight.text = "\(elementToSet.symbol)(\(elementToSet.number)) \(elementToSet.atomic_mass)"
        let elementNumberWithThreeDigits = String(format: "%03d",elementToSet.number)
        ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\(elementNumberWithThreeDigits)/s7.JPG") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                cell.elementImage.image = image
            }
        }
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
