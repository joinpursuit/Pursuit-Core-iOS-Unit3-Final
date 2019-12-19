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
    
    let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        
        ElementAPI.getElements(elementEndpointURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Element Error", "Could not fetch elements. Error: \(netError).")
                }
            case .success(let elementArr):
                self?.elements = elementArr
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            showAlert("Dequeue Error", "Could not dequeue reusable cell as an ElementCell.")
            return UITableViewCell()
        }
        
        do{
            try xCell.setUp(elements[indexPath.row])
        } catch{
            showAlert("Cell Configuration Error", "\(error)")
        }
        return xCell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedElementVC = newStoryboard.instantiateViewController(identifier: "detailedElementVC") as? DetailedElementViewController else {
            showAlert("Segue Error", "Could not instantiate instance of DetailedElementViewController.")
            return
        }
        detailedElementVC.currentElement = elements[indexPath.row]
        navigationController?.pushViewController(detailedElementVC, animated: true)
    }
}
