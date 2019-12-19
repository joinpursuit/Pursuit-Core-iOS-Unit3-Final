//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    static func getElements(completion: @escaping (Result<[Element], AppError>)-> ()) {
        
        let endpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    // get remaining
                    ElementAPIClient.getRemainingElements { (result) in
                        switch result {
                        case .failure(let appError):
                            print(appError)
                        case .success(let remainderElements):
                            completion(.success(elements + remainderElements))
                        }
                    }
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    static func getFavorites(completion: @escaping (Result<[Element], AppError>)-> ()) {
           let endpoint = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
           guard let url = URL(string: endpoint) else {
               completion(.failure(.badURL(endpoint)))
               return
           }
           
           let request = URLRequest(url: url)
           
           NetworkHelper.shared.performDataTask(with: request) { (result) in
               switch result {
               case .failure(let appError):
                   completion(.failure(.networkClientError(appError)))
               case .success(let data):
                   do {
                       let elements = try JSONDecoder().decode([Element].self, from: data)
                       completion(.success(elements))
                   } catch {
                       completion(.failure(.decodingError(error)))
                   }
               }
           }
           
       }
    
    static func getRemainingElements(completion: @escaping (Result<[Element], AppError>)-> ()) {
        
        let endpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
    }
     
    static func postFavorite(favoritedElement: Element, completion: @escaping (Result<Bool, AppError>)-> ()) {
        
        let endpoint = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        do {
            let data = try JSONEncoder().encode(favoritedElement)
            var request = URLRequest(url: url)
                      
                      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                      
                      request.httpBody = data
                      
                      request.httpMethod = "POST"
            
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
    
   
}
