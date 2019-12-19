//
//  ElementsViewController.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
    }
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        
        let element = elements[indexPath.row]
        
        // configure cell
        
        return cell
    }
    
    
}

extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
