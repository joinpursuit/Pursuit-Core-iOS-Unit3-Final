//
//  ElementApiClient.swift
//  Elements
//
//  Created by Ashli Rankin on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class ElementApiClient{
  static func getElement(completionHandler: @escaping (AppError?,[Element]?) -> Void){
    let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, httpResponse) in
      if let error = error {
        completionHandler(AppError.decodingError(error),nil)
      }
      guard let response = httpResponse, (200...299).contains(response.statusCode) else {let statusCode = httpResponse?.statusCode ?? -999
        completionHandler(AppError.badStatusCode(String(statusCode)), nil)
        return}
  
      if let data = data {
        do {
          let elements = try JSONDecoder().decode([Element].self, from: data)
          completionHandler(nil,elements)
        } catch {
          completionHandler(AppError.decodingError(error),nil)
        }
      }
    }
    }
  static func sendFavorite(data:Data,completionHandler: @escaping (AppError?, Bool) -> Void){
  let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
  NetworkHelper.shared.performUploadTask(endpointURLString: urlString, httpMethod: "POST", httpBody: data) { (error, data, httpResponse) in
  if let error = error {
    completionHandler(error,false)
    }
  guard let response = httpResponse, (200...299).contains(response.statusCode) else {
    let statusCode = httpResponse?.statusCode ?? -999
    completionHandler(AppError.badStatusCode(String(statusCode)), false)
    return
    
    }
    if let _  = data {
      completionHandler(nil,true)
    }
  }
}
  static func fetchFavorites(completionHandler: @escaping (AppError?,[ElementEncoded]?) -> Void){
    let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, httpResponse) in
      if let error = error {
        completionHandler(AppError.decodingError(error),nil)
      }
      guard let response = httpResponse, (200...299).contains(response.statusCode) else {let statusCode = httpResponse?.statusCode ?? -999
        completionHandler(AppError.badStatusCode(String(statusCode)), nil)
        return}
      if let data = data {
        do{
          let favoritedElements = try JSONDecoder().decode([ElementEncoded].self, from: data)
          completionHandler(nil,favoritedElements)
        }catch{
          completionHandler(AppError.decodingError(error),nil)
          
        }
      }
    }
  }
}
