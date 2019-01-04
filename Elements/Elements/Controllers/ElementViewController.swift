//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        getElementsData()
        setupRefreshControl()
        tableView.delegate = self
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        //I had a lot of trouble using custom cell...I spent a very long time on it and it's not working so I'm going to complete this using a regular cell.
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else { fatalError("ElementCell error") }
        let elementToSet = elements[indexPath.row]
        //cell.configureCell(element: elementToSet)
        cell.textLabel?.text = elementToSet.name
        cell.detailTextLabel?.text = "\(elementToSet.symbol)(\(elementToSet.number)) \(elementToSet.atomic_mass)"
     //   cell.imageView?.image = UIImage(named: "placeholderImage")
        

        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(formatElementNumber.elementNumberWithThreeDigits(element: elementToSet))/s7.JPG"
        if let url = URL.init(string: imageURL) {
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    cell.imageView?.image = image
                }
            } catch {
                print("image error is: \(error)")
            }
        }
    return cell
    }
}

extension ElementViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        elements = elements.filter{ $0.name.lowercased() == searchText.lowercased() }
    }
}
