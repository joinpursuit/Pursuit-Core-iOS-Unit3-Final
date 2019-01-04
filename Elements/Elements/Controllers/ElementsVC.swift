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
    var element = [Elements](){
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
        dump(element)
    }
    

    //Load Data
    private func loadData(){
        ElementAPIClient.getElements(keyword: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements") { (appError, element) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let element = element {
                self.element = element
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send to DetailVC
    }

}

extension ElementsVC: UITableViewDelegate {
    //UITableViewDelegate is a protocol, it does not require any methods
    //allows us to use any method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
//Set up Table View
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
