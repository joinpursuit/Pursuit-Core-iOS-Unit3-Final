//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


class ElementApiClient {
  
    
    static let manager = ElementApiClient()
    
    func getElements(completionHandler: @escaping (Error?, [Elements]? ) -> Void) {
        let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: urlString) else {
            completionHandler("bad url: \(urlString)" as? Error, nil)
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let response = response {
                print("response code is \(response)")
            }
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let results = try JSONDecoder().decode(Elements.self, from: data)
                    let elements = results
                    completionHandler(error, [elements])
                } catch {
                    completionHandler(error, nil)
                }
            }
            }.resume()
    }
}
