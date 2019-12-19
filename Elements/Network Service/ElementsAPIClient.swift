//
//  ElementsAPIClient.swift
//  Elements
//
//  Created by Yuliia Engman on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    static func fetchElement(completion: @escaping (Result<[Element], AppError>) -> ()) { // for searchQuery: String
        
        //let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" // using to correct transfer what user searches to link it to URL
        
        // using string interpolation to buld endpoint url
        let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        // Later we will look at URLComponents and URLQueryItems
        guard let url = URL(string: elementEndpointURL) else {
            completion(.failure(.badURL(elementEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    // always decode top level struct from the model
                    // if in our model we have only 1 struct - it will be an array
                    // but if it is a higher on it should be just TOP LEVEL (includes array)
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    
                   // let podcasts = searchResults
 
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
//    static func postFavoritePodcast(favoritePodcast: Podcast, completion: @escaping (Result<Bool, AppError>) -> ()) {
//
//      let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
//
//      // create a url
//      guard let url = URL(string: endpointURLString) else {
//        completion(.failure(.badURL(endpointURLString)))
//        return
//      }
//
//      // convert FavoritePodcast to Data
//      do {
//        let data = try JSONEncoder().encode(favoritePodcast)
//
//        // configure our URLRequest
//        // url
//        var request = URLRequest(url: url)
//
//        // type of http method
//        request.httpMethod = "POST"
//
//        // type of data
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // provide data being sent to web api
//        request.httpBody = data
//
//        // execute POST request
//        // either our completion captures Data or an AppError
//        NetworkHelper.shared.performDataTask(with: request) { (result) in
//          switch result {
//          case .failure(let appError):
//            completion(.failure(.networkClientError(appError)))
//          case .success:
//            completion(.success(true))
//          }
//        }
//
//      } catch {
//        completion(.failure(.encodingError(error)))
//      }
//
//    }
//
//
////     GET request: to get all favorites
//    static func fetchFavorites(completion: @escaping (Result<[Podcast], AppError>) -> ()) {
//
//      let favoritsURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
//
//      guard let url = URL(string: favoritsURLString) else {
//        completion(.failure(.badURL(favoritsURLString)))
//        return
//      }
//
//      let request = URLRequest(url: url)
//
//      NetworkHelper.shared.performDataTask(with: request) { (result) in
//        switch result {
//        case .failure(let appError):
//          completion(.failure(.networkClientError(appError)))
//        case .success(let data):
//          do {
//            let favorits = try JSONDecoder().decode([Podcast].self, from: data)
//            completion(.success(favorits))
//          } catch {
//            completion(.failure(.decodingError(error)))
//          }
//        }
//      }
//    }
//
    
}

