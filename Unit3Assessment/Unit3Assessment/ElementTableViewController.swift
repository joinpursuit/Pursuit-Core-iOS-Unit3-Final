//
//  ViewController.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit


class ElementTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var elements = [Element]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    private let endpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    private let endpoint2URL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ElementDetailViewController {
            destVC.element = elements[tableView.indexPathForSelectedRow!.row]
            destVC.title = elements[tableView.indexPathForSelectedRow!.row].name
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: endpointURL) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error decoding from elements: \(error)")
            case .success(let elementsFromAPI):
                self?.elements = elementsFromAPI
            }
        }
        
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: endpoint2URL) { (result) in
            switch result {
            case .failure(let error):
                print("Error decoding from elements_remaining: \(error)")
            case .success(let elementsFromAPI):
                print(elementsFromAPI.count)
                self.elements.append(contentsOf: elementsFromAPI)
            }
        }
    }
    
}

extension ElementTableViewController: UITableViewDelegate {}
extension ElementTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Element Cell", for: indexPath) as? ElementCell else {
            print("Error creating cell as element cell.")
            return UITableViewCell()
        }
        let element = elements[indexPath.row]
        let thumbnailURL = "https://www.theodoregray.com/periodictable/Tiles/\(element.elementNumberInString)/s7.JPG"

        cell.nameLabel.text = element.name
        cell.infoLabel.text = "\(element.symbol)(\(element.name)) \(element.atomicMass)"
        cell.elementImageView.getImage(with: thumbnailURL) { (result) in
            switch result {
            case .failure(let error):
                print("Error getting image: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.elementImageView.image = image
                }
            }
        }
        return cell
    }
}
