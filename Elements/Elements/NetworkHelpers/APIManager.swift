//
//  APIManager.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class APIManager {
    private init(){
    }
    
    static let manager = APIManager()
    
    func getElement(_ completionHandler: @escaping ([Elements]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: urlString) else {
            return
        }
        let completion: (Data) -> (Void) = {(data: Data) in
            do {
                let allElements = try JSONDecoder().decode([Elements].self, from: data)
                completionHandler(allElements)
            }catch {
                print(error)
            }
        }
        NetworkHelp.manager.performDataTask(url, completion, errorHandler )
    }
}
