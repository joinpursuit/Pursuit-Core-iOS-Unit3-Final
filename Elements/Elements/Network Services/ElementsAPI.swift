//
//  ElementsAPI.swift
//  Elements
//
//  Created by Kevin Waring on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementsAPI {
    static func searchElements(keyword: String, completionHandler: @escaping (AppError?, [Element]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        , httpMethod: "GET" , httpBody: nil) {(appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil )
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let elementData = try JSONDecoder().decode([Element].self, from: data )
                    completionHandler(nil, elementData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                    
                }
            }
            
        }
        
    }
   
    static func favoritePodcast(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void ) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false )
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    
                    completionHandler(AppError.badStatusCode(String(statusCode)), false)
                    return
            }
            if let _ = data {
                completionHandler(nil, true )
            }
        }
    }
}
