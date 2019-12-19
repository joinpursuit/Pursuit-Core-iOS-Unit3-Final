//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
var elements = [Element]() {
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self

        loadElement()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        detailVC.element = elements[indexPath.row]
        
    }
    
    private func loadElement(){
        ElementAPICLient.fetchElement(completion: {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Unable to load Elements", message: "\(appError)")}
            case .success(let dataArray):
                self?.elements = dataArray
                dump(self!.elements)
            }
        })
            
        }
    }



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? TableViewCell else{
            fatalError("could not access PodCastCell")
        }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        return cell
    }
    
    
    
}


