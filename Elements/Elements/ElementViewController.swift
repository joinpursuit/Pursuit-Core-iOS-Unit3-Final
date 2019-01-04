//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    @IBOutlet weak var ElementTableView: UITableView!
    
    
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.ElementTableView.reloadData()
            }
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    updateTheElements()
    ElementTableView.dataSource = self
    ElementTableView.delegate = self
    
    
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexpath = ElementTableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? ElementDetailViewController else{return}
        detailViewController.elemental = elements[indexpath.row]
    }
    private func updateTheElements(){
        ElementAPI.elementData { (error, element) in
            if let error = error{
                print(error)
            }
            else if let data = element{
                self.elements = data
            }
        }
    }
    
    
    
    
}


extension ElementViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ElementTableView.dequeueReusableCell(withIdentifier: "elementCell") as? ElementCell else {return UITableViewCell()}
        let selectedElement = elements[indexPath.row]
        
        cell.elementName.text = selectedElement.name
        cell.elementSymbol.text = "\(selectedElement.symbol), \(selectedElement.atomic_mass)"
//
//        func number(elementNumber: Int){
//            ImageHelper.shared.fetchImage(urlString:  "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber)/s7.JPG") { (appError, image) in
//                if let error = appError{
//                    print(error)
//                }
//                else if let pic = image{
//                    cell.ElementPicture.image = pic
//                }
//            }
//        }
        
        
        
        
        
        
         func image(){
            
            switch selectedElement.number {
            case 0...9:
                ImageHelper.shared.fetchImage(urlString:  "http://www.theodoregray.com/periodictable/Tiles/00\(selectedElement.number)/s7.JPG") { (appError, image) in
                    if let error = appError{
                        print(error)
                    }
                    else if let pic = image{
                        cell.ElementPicture.image = pic
                    }
                }
            case 10...99:
                ImageHelper.shared.fetchImage(urlString:  "http://www.theodoregray.com/periodictable/Tiles/0\(selectedElement.number)/s7.JPG") { (appError, image) in
                    if let error = appError{
                        print(error)
                    }
                    else if let pic = image{
                        cell.ElementPicture.image = pic
                    }
                }
            default:
                ImageHelper.shared.fetchImage(urlString:  "http://www.theodoregray.com/periodictable/Tiles/\(selectedElement.number)/s7.JPG") { (appError, image) in
                    if let error = appError{
                        print(error)
                    }
                    else if let pic = image{
                        cell.ElementPicture.image = pic
                    }
                }
            }
        
            
            
        }
        image()

        
        return cell
    }
    
    
    
}



extension ElementViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
