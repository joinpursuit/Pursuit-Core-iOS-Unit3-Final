//
//  ImageHelper.swift
//  Elements
//
//  Created by Tia Lendor on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ImageHelper {
    
    private init() {}
    
    // MARK: - Static Properties
    static let shared = ImageHelper()
    
    // MARK: - Internal Methods
    func getImage(ElementIDWithThreeDigits: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        let urlImageString = "http://www.theodoregray.com/periodictable/Tiles/\(ElementIDWithThreeDigits)/s7.JPG"
        guard let url = URL(string: urlImageString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            
            completionHandler(.success(image))
            
            } .resume()
        
    }
    
}
