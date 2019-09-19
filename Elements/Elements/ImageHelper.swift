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
    
    var elemental: ElementsDetailsForImages!
    
    func getThumbnail(from data: ElementsDetailsForImages.) -> String {
        if number <= 9 {
            return "00\(number)"
        }else if number <= 99 {
            return "0\(number)"
        }
        return "\(number)"
    }
    
    // MARK: - Internal Methods
    func getThumbnailImage(urlStr: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(urlStr)/"
        guard let url = URL(string: urlStr) else {
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
    
    func getElementImage(lowercasedElementName: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        let urlImageString = "http://images-of-elements.com/\(lowercasedElementName).jpg"
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
