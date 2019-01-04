//
//  NetworkHelp.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class NetworkHelp {
    private init () {
        
    }
    let session = URLSession(configuration: .default)
    
    static let manager = NetworkHelp()
    
    func performDataTask(_ url: URL,_ completionHandler: @escaping  (Data) -> (Void), _ errorHandler: @escaping (Error) -> Void ) {
        self.session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                
                if let error = error {
                    errorHandler(error)
                    return
                }
                completionHandler(data)
            }
            }.resume()
    }
}
