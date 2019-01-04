//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class ElementAPIClient {
    static func getAllElements(completionHandler: @escaping (AppError?, [Element]?) -> Void) {
        let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            
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
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completionHandler(nil, elements)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    static func favoriteElement(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
        let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        NetworkHelper.shared.performUploadTask(endpointURLString: urlString, httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
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
}
