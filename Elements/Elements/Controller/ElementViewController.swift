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
    
    private var elements = [Element](){
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
        searchElements(keyWord: "")
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow, let destination = segue.destination as? ElementsDetailViewController else {fatalError("index path nil")}
        let element = elements[indexPath.row]
        destination.element = element
    }
    
    
    
    func searchElements(keyWord: String) {
        ElementsAPI.searchElements(keyword: " "){ (error, element) in
            if let error = error{
                print("error: \(error)")
            }else if let elements = element {
                self.elements = elements
                print("\(elements.count)")
            }
        }
        
    }
}
extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell" , for: indexPath)
//        let elementToSet = elements[indexPath.row]
//        cell.textLabel?.text = elementToSet.name
//        cell.detailTextLabel?.text = elementToSet.symbol
//        //cell.imageView?.image = elementToSet.spectral_img
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {
            fatalError("ElementCell error")
        }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        cell.elementName.text = element.name
        cell.elementSymbol.text = element.symbol
        
        return cell
    }
}
extension ElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

    
    

