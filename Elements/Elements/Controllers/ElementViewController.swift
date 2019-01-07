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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        getElementsData()
        setupRefreshControl()
    }
    
    @objc private func fetchElements() {
        refreshControl.endRefreshing()
        getElementsData()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchElements), for: .valueChanged)
    }
    
    private var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    fileprivate func getElementsData() {
        ElementAPIClient.getAllElements { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.elements = elements
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ElementDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        let elementToSend = elements[indexPath.row]
        destination.element = elementToSend
    }
}

extension ElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else { fatalError("element table view cell not found") }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
    return cell
    }
}

extension ElementViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        elements = elements.filter{ $0.name.lowercased() == searchText.lowercased() }
    }
}
