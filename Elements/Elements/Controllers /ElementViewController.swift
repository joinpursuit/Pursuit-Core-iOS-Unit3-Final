//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    
    @IBOutlet weak var ElementTableView: UITableView!
    
    
    private var AllElements = [Elements]() {
        didSet {
            DispatchQueue.main.async {
                self.ElementTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ElementInfo()
       // ImageFunc()
        ElementTableView.dataSource = self
        ElementTableView.delegate = self
        dump(AllElements)
        
    }

    private func ElementInfo() {
        ElementAPIClient.searchPodcast { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.AllElements = elements
        }
    }
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexpath = ElementTableView.indexPathForSelectedRow,
        let detailViewController = segue.destination as? ElementDetailController else {
            fatalError("indexPath, detailVC nil")
        }
        let ElementInfo = AllElements[indexpath.row]
        detailViewController.ElementDetail = ElementInfo
    }
 
}

extension ElementViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = ElementTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementsCell else {return UITableViewCell()}
        
        let cellSelected = AllElements[indexPath.row]
        
        cell.name.text = cellSelected.name
        cell.symbolETC.text = "\(cellSelected.symbol)(\(cellSelected.number)) \(cellSelected.atomic_mass)"
        let myNumber = cellSelected.number
        
        func updatedNumber(number:String) -> String {
            var empty = ""
        if myNumber < 10 {
            
        let SingleDigitNumber = "00\(myNumber)"
          empty.append(SingleDigitNumber)
            } else if myNumber > 9 || myNumber < 100 {
                let DoubleDigitNumber = "0\(myNumber)"
            empty.append(DoubleDigitNumber)
        } else if myNumber > 99 {
            let tripleDigitNumber = "\(myNumber)"
            empty.append(tripleDigitNumber)
            }
            return empty
        }
        
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(updatedNumber(number: "\(cellSelected.number)"))/s7.JPG"
        let myImage = URL.init(string: imageURL)
        do {
            let dataer = try Data.init(contentsOf: myImage!)
            cell.ElementImage.image = UIImage.init(data: dataer)
        } catch {
            print(error)
        }
        return cell
    }
    

}
extension ElementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}


