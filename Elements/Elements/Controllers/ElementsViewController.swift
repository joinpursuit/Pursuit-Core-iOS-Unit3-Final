//
//  ViewController.swift
//  Elements
//
//  Created by J on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
  private var elements = [Element]() {
    didSet {
      DispatchQueue.main.async {
          self.elementsTable.reloadData()
      }
    }
  }
  
  @IBOutlet weak var elementsSearchBar: UISearchBar!
  @IBOutlet weak var elementsTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getElements()
    elementsTable.dataSource = self
    elementsTable.delegate = self
    elementsSearchBar.delegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let detailVC = segue.destination as? ElementDetailsController,
      let indexPath = elementsTable.indexPathForSelectedRow else {
        fatalError("Index Path or ViewController not present")
    }
    let element = elements[indexPath.row]
    detailVC.element = element
  }
  
  private func getElements(){
    ElementAPIClient.getElements { (error, elements) in
      if let error = error {
        let errorVC = UIAlertController.errorController(error: error)
        self.present(errorVC, animated: true, completion: nil)
      }
      if let elements = elements {
        self.elements = elements
      }
    }
  }

}

extension ElementsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = elementsTable.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell, elements.count > 0 else { return UITableViewCell() }
    let element = elements[indexPath.row]
    cell.elementNameLabel.text = element.name
    cell.elementDetailsLabel.text = "\(element.symbol) (\(element.number)) \(element.atomic_mass)"
    let url = "http://www.theodoregray.com/periodictable/Tiles/\(element.elementNumber)/s7.JPG"
    ImageHelper.fetch(urlString: url) { (error, image) in
      if let error = error {
        cell.elementImageView.image = UIImage(named: "placeholder")
      }
      
      if let image = image {
        cell.elementImageView.image = image
      }
    }
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elements.count
  }
}
extension ElementsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}

extension ElementsViewController : UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == "" {
      getElements()
      return
    }
    elements = elements.filter {$0.name.contains(searchText)}
  }
}

