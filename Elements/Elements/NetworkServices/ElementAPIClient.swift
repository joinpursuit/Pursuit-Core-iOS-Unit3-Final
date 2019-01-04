//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Donkemezuo Raymond Tariladou on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PeriodicElementAPIClient {
    
    static func getElements(completionHandler: @escaping(AppError?,[Elements]?) -> Void){
        
        let endPointUrlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        NetworkHelper.shared.performDataTask(endpointURLString: endPointUrlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do{
                    let elements = try JSONDecoder().decode([Elements].self, from: data)
                    completionHandler(nil,elements)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
        
    }

    
    static func favoriteElement(data: Data, completionHandler: @escaping(AppError?, Bool) -> Void){
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false)
            }
            guard let response = httpResponse,(200...299).contains(response.statusCode) else {
                
                
                let statusCode = httpResponse?.statusCode ?? -99
                completionHandler(AppError.badStatusCode(String(statusCode)), false)
                return
            }
            if let _ = data {
                completionHandler(nil, true)
            }
        }
    }
    
    
    
    static func getFavoriteElement(completionHandler: @escaping(AppError?, [Favorite]?) -> Void){
        let favoriteElementEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        NetworkHelper.shared.performDataTask(endpointURLString: favoriteElementEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let favoriteElement = try JSONDecoder().decode([Favorite].self, from: data)
                    completionHandler(nil, favoriteElement)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }

}
