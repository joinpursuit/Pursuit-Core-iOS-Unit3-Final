//
//  ElementAPIManager.swift
//  Elements
//
//  Created by Tia Lendor on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class ElementApiManager {
    private init () {}
    
    static let shared = ElementApiManager()
    
    func getElements(completionHandler: @escaping (Result<[Elements], AppError>) -> Void) {
        let urlStr = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        guard let url = URL(string: urlStr) else {completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data) :
                do {
                    let elementInfo = try JSONDecoder().decode([Elements].self, from: data)
                    completionHandler(.success(elementInfo))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
