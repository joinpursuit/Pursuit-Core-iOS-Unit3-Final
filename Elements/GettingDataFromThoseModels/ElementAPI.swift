//
//  ElementAPI.swift
//  Elements
//
//  Created by Jason on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit

final class ElementAPI{
    static func elementData(complete: @escaping(AppError?, [Element]?) -> Void){
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, urlResponse) in
            if let error = appError{
                complete(error, nil)
                
            }
            
            if let response = urlResponse{
                (200...299).contains(response.statusCode)
            } else {
                    let statusCode = urlResponse?.statusCode ?? -999
                    complete(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            
            if let elementData = data{
                    do {
                        let element = try JSONDecoder().decode([Element].self, from: elementData)
                        complete(nil, element)
                    } catch {
                        complete(AppError.decodingError(error), nil)
                    }
            }
            
            
        }
    }
    
    static func favoriteElement(data: Data, complete: @escaping (AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, urlResponse) in
            if let appError = appError {
                complete(appError, false)
            }
            guard let response = urlResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = urlResponse?.statusCode ?? -999
                    complete(AppError.badStatusCode(String(statusCode)), false)
                    return
            }
            if let data = data {
                do {
                    let podcastData = try JSONDecoder().decode(FavoriteElement.self, from: data)
                    complete(nil, true)
                } catch {
                    complete(AppError.decodingError(error), false)
                }
            }
        }
        
    }
    
    
    
    
}
