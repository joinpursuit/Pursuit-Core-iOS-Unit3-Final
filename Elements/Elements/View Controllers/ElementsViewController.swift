//
//  ElementsViewController.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

  @IBOutlet weak var elementsTableView: UITableView!
  
  
  private var elementsforTable = [Elements]() {
    didSet{
      DispatchQueue.main.async {
        self.title = "Elements \(self.elementsforTable.count)"
        self.elementsTableView.reloadData()
      }
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      elementsTableView.dataSource = self
      elementsTableView.delegate = self
      searchElement()

    }
  
  private func searchElement() {
    ElementAPIClient.searchElement{ (appError, elements) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let elements = elements {
        self.elementsforTable = elements
        print(self.elementsforTable.count)

      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = elementsTableView.indexPathForSelectedRow,
      let elementInDetailVC = segue.destination as? DetailedElementsVC else {fatalError("segue or indexPath error")}
    
    let currentElementToSegue = elementsforTable[indexPath.row]
    elementInDetailVC.elementsForDeatiled = currentElementToSegue
    
  }

}

extension ElementsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elementsforTable.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = elementsTableView.dequeueReusableCell(withIdentifier: "ElementsCell", for: indexPath) as? ElementsCustomCell else {fatalError("ElementCell error")}
    
    let currentElement = elementsforTable[indexPath.row]
    
    cell.configureCell(element: currentElement)
    
    
    return cell
    
  }
}

extension ElementsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
