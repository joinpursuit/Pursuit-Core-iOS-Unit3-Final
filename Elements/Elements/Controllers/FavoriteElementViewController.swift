//
//  FavoriteElementViewController.swift
//  Elements
//
//  Created by Ashli Rankin on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteElementViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  private var elements = [ElementEncoded](){
    didSet{
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  var refreshControl:UIRefreshControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      getTheFavElements()
      collectionView.dataSource = self
      setUpRefreshControl()
    }
  private func setUpRefreshControl(){
    refreshControl = UIRefreshControl()
    collectionView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(getTheFavElements), for: .valueChanged)
    
    
  }
  @objc private func getTheFavElements(){
    ElementApiClient.fetchFavorites { (error, elements) in
      if let error = error {
        print(error.errorMessage())
      }
      if let elements = elements{
        self.elements = elements.filter{$0.favoritedBy == "Ashli Rankin"}
      }
    }
  }
    private func getTheImages(urlString:String,imageView:UIImageView){
      ImageHelper.shared.fetchImage(urlString: urlString) { (error, image) in
        if let error = error{
          print(error.errorMessage())
        }
        if let image = image {
          imageView.image = image
          
        }
      }
    }
}

extension FavoriteElementViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return elements.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let element = elements[indexPath.row]
    let urlString = "http://images-of-elements.com/\(element.elementName.lowercased()).jpg"
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FaveElementCollectionViewCell else {return UICollectionViewCell()}
    getTheImages(urlString: urlString, imageView: cell.elementImage)
    cell.elementName.text = "Name: \(element.elementName.capitalized)"
    cell.elementSymbol.text = "Symbol: \(element.elementSymbol.capitalized)"
    return cell
  }
  
  
}
