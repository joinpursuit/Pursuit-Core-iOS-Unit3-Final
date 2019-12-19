//
//  ElementAPI.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPI {
    static func getElements(completion: @escaping (Result<[Element],NetworkError>) -> ()){
        let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: elementEndpointURL) else {
            completion(.failure(.badURL(elementEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result {
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postElement(_ element: Element, completion: @escaping (Result<Bool,NetworkError>) -> ()){
        let postEndpointURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        guard let url = URL(string: postEndpointURL) else {
            completion(.failure(.badURL(postEndpointURL)))
            return
        }
        do {
            let data = try JSONEncoder().encode(element)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            NetworkHelper.shared.performDataTask(request) { result in
                switch result{
                case .failure(let netError):
                    completion(.failure(.networkClientError(netError)))
                case .success:
                    completion(.success(true))
                }
            }
            
        } catch{
            completion(.failure(.encodingError(error)))
        }
    }
}
