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
    
    private var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.title = "\(self.elements.count)"
                self.tableView.reloadData()
            }
        }
    }
   
    
  override func viewDidLoad() {
    super.viewDidLoad()
    searchElement()
    tableView.dataSource = self
    dump(elements)
  }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? DetailViewController else {
                fatalError("tndexPath is nil")
        }
        let elementToSegue = elements[indexPath.row]
        detailVC.selectedElement = elementToSegue
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = tableView.indexPathForSelectedRow,
//            let detailVC = segue.destination as? PodcastDetailViewController else {
//                fatalError("indexPath, detailVC nil")
//        }
//        let podcasts = podcast[indexPath.row]
//        detailVC.selectedPodcast = podcasts
//    }
    
    
    private func searchElement() {
        ElementAPIClient.searchElement{ (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
              //  print("\(element.count)")
                self.elements = elements
            }
        }
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        let theElement = elements[indexPath.row]
        cell.textLabel?.text = theElement.name
       
        if let image = ImageHelper.shared.image(forKey: "http://www.theodoregray.com/periodictable/Tiles/\((String(format:"%03d", theElement.number)))//s7.JPG" as NSString) {
            cell.imageView?.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\((String(format:"%03d", theElement.number)))/s7.JPG") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.imageView?.image = image
                }
            }
        }
          return cell
    }
}
