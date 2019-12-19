//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    static func fetchElements(completion: @escaping (Result<[ElementInfo], AppError>) ->()) {
        let elementEndpointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: elementEndpointURLString) else {
            completion(.failure(.badURL(elementEndpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data) :
                do {
                    let elements = try JSONDecoder().decode([ElementInfo].self, from: data)
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
