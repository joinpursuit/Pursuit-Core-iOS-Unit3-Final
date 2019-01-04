//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var elementsTableView: UITableView!
    var allElements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.elementsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.dataSource = self
        elementsTableView.delegate = self
        
        ElementAPIClient.getAllElements { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.allElements = elements
                //dump(self.allElements)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementsTableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? ElementDetailViewController else {
                fatalError("indexPath, detailVC nil")
        }
        
        let element = allElements[indexPath.row]
        detailVC.element = element
    }

}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allElements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = elementsTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {
            fatalError("ElementCell Error")
        }
        let element = allElements[indexPath.row]
        cell.elementName.text = element.name
        cell.elementInfo.text = "\(element.symbol)(\(element.number)) \(element.atomicMass)"
        
//        if let image = ImageHelper.shared.image(forKey: <#T##NSString#>)
//        ImageHelper.shared.fetchImage(urlString: <#T##String#>) { (appError, image) in
//
//        }
//
        return cell
    }
    
    //private func getThumbnail
}

extension ElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
