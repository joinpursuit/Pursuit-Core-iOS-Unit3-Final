//
//  APIClient.swift
//  Elements
//
//  Created by Ian Bailey on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

final class APIClient {
    static func loadData(completionHandler: @escaping ((AppError?, [ElementData]? )-> Void)) {
        let url = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        NetworkHelper.shared.performDataTask(endpointURLString: url, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            }
            if let data = data {
                do {
                    let elementInfo = try JSONDecoder().decode([ElementData].self, from: data)
                    completionHandler(nil, elementInfo)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
            
        }
        
    }

static func uploadData(data: Data, completionHandler: @escaping ((AppError?, Bool ) -> Void)) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false)
            }
            if let _ = data {
                completionHandler(nil, true)
            }
        }
        
    }


static func getFavorites(completionHandler: @escaping (AppError?, [FavoriteElements]?) -> Void) {
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
                let favorites = try JSONDecoder().decode([FavoriteElements].self, from: data)
                completionHandler(nil, favorites)
            } catch {
                completionHandler(AppError.decodingError(error), nil)
            }
        }
    }
}

}
