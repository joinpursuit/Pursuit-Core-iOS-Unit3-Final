//
//  ElementsVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
 
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Element Chart"
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    
    private func loadData() {
        ElementAPIClient.getElements { (appError, element) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let element = element {
                self.elements = element
            }
        }
    }
    


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow, let detailVC1 = segue.destination as? DetailElementVC else {
        fatalError("indexPath, detailVC nil")
        
    }
    let element = elements[indexPath.row]
    detailVC1.element = element
}
    
}

extension ElementsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

extension ElementsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {fatalError("ElementCell not found") }
        let path = elements[indexPath.row]
        cell.name.text = path.name
        cell.otherThing.text = "\(path.symbol)(\(path.number))\(path.atomicMass)"
        return cell
    }
}
