//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Jose Alarcon Chacon on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementAPIClient{
    
    static func searchElement(completionHandle: @escaping(AppError?, [Element]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandle(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandle(AppError.badStatusCode(String(statusCode)),nil)
                    return
            }
            if let data = data {
                do {
                    let elementdata = try JSONDecoder().decode(ElementData.self, from: data)
                    completionHandle(nil,elementdata.elements)
                    print(elementdata)
                } catch {
                    completionHandle(AppError.decodingError(error), nil)
                }
            }
        }
    }
    static func favoriteElement(data: Data, completionHandle: @escaping(AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandle(appError, false)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    
                    completionHandle(AppError.badStatusCode(String(statusCode)),false)
                    return
            }
            if let _ = data {
                completionHandle(nil, true)
            }
        }
    }
}
