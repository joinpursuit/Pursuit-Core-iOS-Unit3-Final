//
//  ElementsVC.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsVC: UIViewController {

    //tableView
    @IBOutlet weak var tableView: UITableView!
    
    // instance of the model
    var elements = [Elements](){
        didSet{//after it loads change the value
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self//sets cells according to data
        tableView.delegate = self // intrinsic height
        loadData() // gives me my data
    }
    

    //Load Data
    private func loadData() {
        ElementApiClient.getElement { (error, elements) in
            if let error = error {
                print("#Error:\(error)")
                print("#Error:\(error.errorMessage())")
                print("#Error:\(error.localizedDescription)")
            } else if let elements = elements {
                self.elements = elements
                print(elements)
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send to DetailVC
    }

}

extension ElementsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ElementsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {fatalError("ElementCell not found") }
        cell.name.text = "Joshua"
        cell.otherThing.text = "Viera"
        return cell
    }
}
