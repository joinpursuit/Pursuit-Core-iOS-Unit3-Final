//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementAPIClient {
  static func searchElement(completionHandler: @escaping (AppError?, [Elements]?) -> Void) {
    let getElementEndPoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    NetworkHelper.shared.performDataTask(endpointURLString: getElementEndPoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let elementsData = try JSONDecoder().decode([Elements].self, from: data)
          completionHandler(nil, elementsData)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
  // uploading json data to the network api
  static func favoriteElement(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
    let postFavorite = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    NetworkHelper.shared.performUploadTask(endpointURLString: postFavorite, httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, false)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), false)
          return
      }
      // TODO: create a favorite and confirm favoriteId
      if let _ = data {
        completionHandler(nil, true)
      }
    }
  }
  
  // get favorites
//  static func getFavorites(name: String, completionHandler: @escaping (AppError?, [Favorite]?) -> Void) {
//    let getFavoritesEndpoint = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites?search=\(name)"
//    NetworkHelper.shared.performDataTask(endpointURLString: getFavoritesEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
//      if let appError = appError {
//        completionHandler(appError, nil)
//      }
//      guard let response = httpResponse,
//        (200...299).contains(response.statusCode) else {
//          let statusCode = httpResponse?.statusCode ?? -999
//          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
//          return
//      }
//      if let data = data {
//        do {
//          let favorites = try JSONDecoder().decode([Favorite].self, from: data)
//          completionHandler(nil, favorites)
//        } catch {
//          completionHandler(AppError.decodingError(error), nil)
//        }
//      }
//    }
//  }
  
}
