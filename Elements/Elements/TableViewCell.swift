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

     private var urlString = ""
        
        
        func configureCell(podcast: Podcast){
            label.text = """
            \(podcast.collectionName)\n\(podcast.artistName ?? "")
            
    """
            guard let imageURL = podcast.artworkUrl100 else {
                podcastImage.image = UIImage(systemName: "mic.fill")
                return
            }
    //        urlString = imageURL
            
            podcastImage.getImage(with: imageURL) {[weak self] (result) in
                switch result{
                case .failure:
                    DispatchQueue.main.async{//async- right away with no interruptions
                        self?.podcastImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                        
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.podcastImage.image = image
                        
                    }
                }
                
            }
        }
         override func prepareForReuse() {
                super.prepareForReuse()
                podcastImage.image = UIImage(systemName: "mic.fill")
            }
        
        
        }


}
