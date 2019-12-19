//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    
    static func fetchRemaining (completion: @escaping (Result<[ElementInfo], AppError>) ->()) {
        let remaininElementsURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
        
                guard let url2 = URL(string: remaininElementsURL ) else {
                    completion(.failure(.badURL(remaininElementsURL)))
                    return
                }
        
        let request2 = URLRequest(url: url2)
        
        
                NetworkHelper.shared.performDataTask(with: request2) { (result) in
                    switch result {
                    case .failure(let appError):
                        completion(.failure(.networkClientError(appError)))
                    case .success(let data) :
                        do {
                            let extraElements = try JSONDecoder().decode([ElementInfo].self, from: data)
                            completion(.success(extraElements ))
                        } catch {
                            completion(.failure(.decodingError(error)))
                        }
                    }
                }
        
    }
    
    static func fetchElements(completion: @escaping (Result<[ElementInfo], AppError>) ->()) {
        let elementEndpointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
     
        
        guard let url = URL(string: elementEndpointURLString ) else {
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
//                    fetchRemaining { (result) in
//                        <#code#>
//                    }
                    // TODO: before you write the completion call ther remainging elements
                    
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        

    }
    
    static func postElement(element: ElementInfo, completion: @escaping (Result<Bool,AppError>) -> ()) {
        
        let endpoinURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpoinURL) else {
            completion(.failure(.badURL(endpoinURL)))
            return
        }
        do {
            let data = try JSONEncoder().encode(element)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
            
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func fetchFavorites(completion: @escaping (Result<[ElementInfo], AppError>) -> ()) {
        
        let favoriteURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: favoriteURLString) else {
            completion(.failure(.badURL(favoriteURLString)))
            return
        }
         let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                   let favotritePodcasts = try JSONDecoder().decode([ElementInfo].self, from: data)
                    completion(.success(favotritePodcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
