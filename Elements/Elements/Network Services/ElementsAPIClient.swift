//
//  ElementsAPIClient.swift
//  Elements
//
//  Created by Nathalie  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementsAPIClient {
    
    static func getElements(completionHandler: @escaping (AppError?, [Element]?) -> Void) {
        let getElementsEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        NetworkHelper.shared.performDataTask(endpointURLString: getElementsEndpoint,
                                             httpMethod: "GET",
                                             httpBody: nil) { (appError, data, httpResponse) in
                                                if let appError = appError {
                                                    completionHandler(appError, nil)
                                                } else if let data = data {
                                                    do {
                                                        let posts = try JSONDecoder().decode([Element].self, from: data)
                                                        completionHandler(nil, posts)
                                                    } catch {
                                                        completionHandler(AppError.decodingError(error), nil)
                                                    }
                                                }
        }
    }
    
    
    static func favoriteElement(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), false)
                    return
            }
            
            if let _ = data {
                completionHandler(nil, true)
            }
        }
    }
    
    static func getFavorites(name: String, completionHandler: @escaping (AppError?, [Favorite]?) -> Void) {
        let getFavoritesEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        NetworkHelper.shared.performDataTask(endpointURLString: getFavoritesEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
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
                    let favorites = try JSONDecoder().decode([Favorite].self, from: data)
                    completionHandler(nil, favorites)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
}

