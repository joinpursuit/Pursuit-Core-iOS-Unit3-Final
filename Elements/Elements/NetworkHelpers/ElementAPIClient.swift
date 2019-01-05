//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.



import Foundation

final class ElementAPIClient {
    static func getElements(completionHandler: @escaping ((AppError?, [Element]?) -> Void)) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let element = try JSONDecoder().decode([Element].self, from: data)
                    completionHandler(nil, element)
                    dump(data)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
