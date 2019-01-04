//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.elementTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var elementTableView: UITableView!
    override func viewDidLoad() {
        elementTableView.dataSource = self
        elementTableView.delegate = self
        
        super.viewDidLoad()
        
        ElementAPIClient.getElements { (error, elements) in
            if let error = error{
                print(error)
            }
            if let elements = elements {
                self.elements = elements
            }
            dump(elements)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = elementTableView.indexPathForSelectedRow, let elementDetailViewController = segue.destination as? ElementDetailViewController else {fatalError("missing index path, elementDetailViewController")}
        let elementInfo = elements[indexPath.row]
        elementDetailViewController.elementInfo = elementInfo
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {return UITableViewCell()}
        let elementToSet = elements[indexPath.row]
        cell.elementName.text = elementToSet.name
        cell.elementSymAndWeight.text = elementToSet.symbol + "(\(String(elementToSet.number)))" + " " + String(elementToSet.atomic_mass)
        if let imageUrl = elementToSet.spectral_img?.absoluteString{
            if let image = ElementTableViewCell.getImage(stringURL: imageUrl){
                cell.elementIMG.image = image
            }
    
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}

