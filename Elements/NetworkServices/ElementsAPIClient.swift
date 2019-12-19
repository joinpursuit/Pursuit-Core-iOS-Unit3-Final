//
//  ElementsAPIClient.swift
//  Elements
//
//  Created by Oscar Victoria Gonzalez  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsAPIClient {
    static func getElements(completion: @escaping (Result <[Elements], AppError>)-> ()) {
        
        let endpointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let element = try JSONDecoder().decode([Elements].self, from: data)
                    completion(.success(element))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
