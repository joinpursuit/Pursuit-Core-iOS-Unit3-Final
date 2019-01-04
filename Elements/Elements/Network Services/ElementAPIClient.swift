//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementAPIClient {
    static func getAllElements(completionHandler: @escaping (AppError?, [Element]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }
            if let data = data {
                do {
                    let elementData = try JSONDecoder().decode([Element].self, from: data)
                    completionHandler(nil, elementData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    static func favoriteElement(data: Data, completionHander: @escaping (AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHander(appError, false)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHander(AppError.badStatusCode(statusCode.description), false)
                    return
                }
                if let _ = data {
                    completionHander(nil, true)
                }
            }
    }
}
