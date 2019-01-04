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
 
    var allElements = [Elements](){
        didSet{
                self.tableView.reloadData()
            }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        loadData()
        getInfo()
    }
    
    func getInfo() {
        APIManager.manager.getElement({ (infoFromOnline) in
            self.allElements = infoFromOnline
        }) { (error) in
            print(error)
        }
    }
//    private func loadData() {
//        ElementAPIManager.manager.getElement { (error, elements) in
//            if let error = error {
//                print("#Error:\(error)")
//                print("#Error:\(error.localizedDescription)")
//            } else if let elements = elements {
//                self.elements = elements
//                print(elements)
//            }
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension ElementsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ElementsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allElements.count
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {fatalError("ElementCell not found") }
//        cell.name.text = allElements.name
//        cell.otherThing.text = allElements
        return cell
    }
}
