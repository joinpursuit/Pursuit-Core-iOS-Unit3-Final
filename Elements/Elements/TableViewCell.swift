//
//  TableViewCell.swift
//  Elements
//
//  Created by Tanya Burke on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit


//
//* Build a table view that loads and displays a list of the Elements, one per cell/row. Use a custom UITableViewCell subclass.  It should have 2 labels and one image.  The image should be pinned to the left of cell from the small images endpoint below.  The labels should be configured as below:
//
//    ```
//    Name
//    Symbol(Number) Atomic Weight
//
//    e.g.
//
//    Sodium
//    Na(11) 22.989769282
//    ```
class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var infoLabel:UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    
     private var urlString = ""
        
        
        func configureCell(element: Element){
            //assign stuff to labels in cell
            label.text = """
        
    """
            //have to make function to get the images
            //it would be element.number that would be used to access the images
            guard let imageURL = element.number
                else {
                elementImage.image = UIImage(systemName: "mic.fill")
                return
            }
    //        urlString = imageURL
            
            elementImage.getImage(with: imageURL) {[weak self] (result) in
                switch result{
                case .failure:
                    DispatchQueue.main.async{//async- right away with no interruptions
                        self?.elementImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                        
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.elementImage.image = image
                        
                    }
                }
                
            }
        }
         override func prepareForReuse() {
                super.prepareForReuse()
                elementImage.image = UIImage(systemName: "mic.fill")
            }
        
        
        }



