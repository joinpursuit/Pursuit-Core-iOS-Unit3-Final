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
    getElements()
  }

    private func getElements() {
        ElementsAPIClient.getElements(completionHandler: { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.elements = elements
            }
        }
    )}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailViewController else { return }
        let myElements = elements[indexPath.row]
        detailViewController.element = myElements
    }

}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var numberString = ""
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("could not find custom cell")
        }
        let element = elements[indexPath.row]
        if element.number < 10 {
         numberString = "00\(element.number)"
        } else if element.number > 10 && element.number < 100 {
         numberString = "0\(element.number)"
        }
        //
        cell.elementName.text = element.name
        cell.elementInfo.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        if let image = ImageHelper.shared.image(forKey: "http://www.theodoregray.com/periodictable/Tiles/\(numberString)/s7.JPG" as NSString) {
            cell.elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\(numberString)/s7.JPG") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.elementImage.image = image
                }
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
        return 150
    }
}

