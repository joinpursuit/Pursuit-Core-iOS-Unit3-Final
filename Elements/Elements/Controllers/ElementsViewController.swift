//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //private var refreshControl: UIRefreshControl!
    
    public var elements = [Elements]() {
        didSet {
            DispatchQueue.main.async {
                //self.title = "This is element (\(self.posts.count))"
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
      
        loadData()
       
        
        
    }
    
    private func loadData() {
        ElementsAPIClient.getElements { (error, elements) in
            if let element = elements {
                DispatchQueue.main.async {
                    self.elements = element
                }
                
            }
        }
        
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as?
            ElementsDetailViewController else {
                fatalError("indexPath, detailVC nil")
        }
        let element = elements[indexPath.row]
        detailViewController.element = element
    }
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ElementsCell", for: indexPath) as! ElementsCell 
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        return cell 
    }
}
extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
