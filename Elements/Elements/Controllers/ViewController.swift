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
        self.tableView.reloadData()
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    getTheElements()
    tableView.dataSource = self
    tableView.delegate = self
  }
  private func getTheElements(){
    ElementApiClient.getElement { (error, elements) in
      if let error = error {
        print(error.errorMessage())
      }
      if let elements = elements{
        self.elements = elements
        dump(elements)
      }
    }
  }
  func formatsNumbers(elementCount: Int) -> [String]{
    var formattedString = [String]()
    for myInt in 1...elementCount {
      formattedString.append(String(format: "%03d", myInt))
    }
    return formattedString
  }
  private func getTheThumbmailImages(formattedString:String,imageView:UIImageView){
    let urlString = "http://www.theodoregray.com/periodictable/Tiles/\(formattedString)/s7.JPG"
    ImageHelper.shared.fetchImage(urlString: urlString) { (error, image) in
      if let error = error {
        print(error.errorMessage())
      }
      if let image = image {
        DispatchQueue.main.async {
           imageView.image = image
        }
      }
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow,
      let elementDetailledView = segue.destination as? ElementDetailledViewController else {fatalError("No destination found")}
    elementDetailledView.element = elements[indexPath.row]
  }
}
extension ViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let formattedStringArray = formatsNumbers(elementCount: elements.count)
    let formattedString = formattedStringArray[indexPath.row]
    let element = elements[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementTableViewCell else {return UITableViewCell()}
 getTheThumbmailImages(formattedString: formattedString, imageView: cell.elementImage)
    cell.elementName.text = "Name: \(element.name.capitalized)"
    cell.elementSymboll.text = "Symbol: \(element.symbol.capitalized)"
    return cell
  }
}
extension ViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}
