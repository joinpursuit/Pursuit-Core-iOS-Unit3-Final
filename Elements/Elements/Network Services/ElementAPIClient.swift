//
//  ElementAPIClient.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
final class ElementAPIClient {
  public static func getElements(completion:@escaping (AppError?, [Element]?) -> Void){
    let url = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    NetworkHelper.shared.performDataTask(endpointURLString: url, httpMethod: "GET", httpBody: nil) { (error, data, response) in
      if let error = error {
        completion(AppError.networkError(error), nil)
      }
      
      guard let httpResponse = response, (200...299).contains(httpResponse.statusCode) else {
        return
      }
      if let data = data {
        do {
          let elements = try JSONDecoder().decode([Element].self, from: data)
          completion(nil, elements)
        }catch {
          completion(AppError.decodingError(error), nil)
        }
      }
    }
  }
  public static func getImage(element:Element, completion:@escaping(Error?, UIImage?) -> Void){
    let url = "http://www.theodoregray.com/periodictable/Tiles/\(element.elementNumber)/s7.JPG"
    
    ImageHelper.fetch(urlString: url) { (error, image) in
      if let error = error {
        completion(error, nil)
      }
      
      if let image = image {
        completion(nil, image)
      }
    
    }
  }
  public static func postFavoriteElement(favoriteElement: Data, completion: @escaping (AppError?, Int?, Bool) -> Void){
    let url = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    
    NetworkHelper.shared.performUploadTask(endpointURLString: url, httpMethod: "POST", httpBody: favoriteElement) { (error, data, response) in
      
      if let error = error {
        completion(AppError.networkError(error), response?.statusCode, false)
        return
      }
      
      guard let httpResponse = response,
        (200...299).contains(httpResponse.statusCode) else {
          completion(nil, response?.statusCode, false)
          return
      }
      
      completion(nil, httpResponse.statusCode, true)
    }
  }
  public static func getFavorites(completion:@escaping(AppError?, [FavoriteElement]?) -> Void){
    let url = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    NetworkHelper.shared.performDataTask(endpointURLString: url, httpMethod: "GET", httpBody: nil, caching: false) { (error, data, response) in
      if let error = error {
        completion(AppError.networkError(error), nil)
      }
      
      guard let httpResponse = response, (200...299).contains(httpResponse.statusCode) else {
        return
      }
      if let data = data {
        do {
          let elements = try JSONDecoder().decode([FavoriteElement].self, from: data)
          completion(nil, elements)
        }catch {
          completion(AppError.decodingError(error), nil)
        }
      }
    }
  }
}

