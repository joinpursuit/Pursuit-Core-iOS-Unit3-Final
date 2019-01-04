//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    private var elements = [Element]() {
        didSet{
            DispatchQueue.main.async {
                self.elementTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var elementTableView: UITableView!
   
    override func viewDidLoad() {
    super.viewDidLoad()
    elementTableView.dataSource = self
    elementTableView.delegate = self
    getElements()
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementTableView.indexPathForSelectedRow,
            let detailView = segue.destination as? ElementDetailViewController else {return}
        let element = elements[indexPath.row]
        detailView.element = element
    }
    private func getElements() {
        ElementAPI.getElement{(appError, elements) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let elements = elements{
                self.elements = elements
            }
        }
    }

}

extension ElementsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = elementTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {return UITableViewCell()}
        let elementToSet = elements[indexPath.row]
        cell.elementName.text = elementToSet.name
        cell.elementDetails.text = "\(elementToSet.symbol)(\(elementToSet.number)) \(elementToSet.atomicMass)"
        if let image = ImageHelper.shared.image(forKey: "http://www.theodoregray.com/periodictable/Tiles/\((String(format: "%03d", elementToSet.number)))/s7.JPG" as NSString) {
            cell.elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\((String(format: "%03d", elementToSet.number)))/s7.JPG") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.elementImage.image = image
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
