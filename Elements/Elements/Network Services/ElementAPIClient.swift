//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Biron Su on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementAPIClient{
    static func getElements(completionHandler: @escaping (AppError?, [Elements]?) -> Void) {
        let getElementEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        NetworkHelper.shared.performDataTask(endpointURLString: getElementEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
                if let appError = appError {
                    completionHandler(appError, nil)
                } else if let data = data {
                    do {
                        var elements = try JSONDecoder().decode([Elements].self, from: data)
                        elements = elements.sorted{$0.number < $1.number}
                        completionHandler(nil,elements)
                    } catch {
                        completionHandler(AppError.decodingError(error), nil)
                    }
                }
        }
    }
    static func favoriteElement(data: Data, completion: @escaping (Bool) -> Void) {
        let favoriteElementEndPoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        NetworkHelper.shared.performUploadTask(endpointURLString: favoriteElementEndPoint, httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let _ = appError {
                completion(false)
            } else if let _ = data {
                completion(true)
            }
        }
    }
    static func getFavoriteElement(keyword: String, completionHandler: @escaping (AppError?, [Favorite]?) -> Void) {
        let getFavoriteElementEndPoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        NetworkHelper.shared.performDataTask(endpointURLString: getFavoriteElementEndPoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    var elements = try JSONDecoder().decode([Favorite].self, from: data)
                    elements = elements.filter{$0.favoritedBy.contains(keyword)}
                    completionHandler(nil,elements)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
