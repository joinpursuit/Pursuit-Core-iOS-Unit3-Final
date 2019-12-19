//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var refreshControl: UIRefreshControl!
    let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    let remainingElementsURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureRefreshControl()
    }
    
    // MARK: Helper Methods
    @objc
    private func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        
        ElementAPI.getElements(elementEndpointURL) { [weak self] result in
            
            DispatchQueue.main.async{
                self?.refreshControl.endRefreshing()
            }
            
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Element Error", "Could not fetch elements. Error: \(netError).")
                }
            case .success(let elementArr):
                self?.elements = elementArr
            }
        }
        
        ElementAPI.getElements(remainingElementsURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Element Error", "Could not fetch remaining elements. Error: \(netError)")
                }
            case .success(let elementArr):
                self?.elements += elementArr
            }
        }
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(setUp), for: .valueChanged)
    }
}

// MARK: UITableView Data Source Methods
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

// MARK: UITableView Delegate Methods
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
