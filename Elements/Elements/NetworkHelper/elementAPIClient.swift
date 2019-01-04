//
//  elementAPIClient.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class elementAPIClient {
    static func getElements(completionHandler: @escaping (AppError?, [Element]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
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
                  let elementData = try JSONDecoder().decode([Element].self, from: data)
                    print("got data")
                    completionHandler(nil, elementData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    
    
    
    
}
