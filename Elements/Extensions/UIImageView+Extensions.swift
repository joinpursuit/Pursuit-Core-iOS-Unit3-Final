//
//  UIImage+Extensions.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(_ thumbnailEndpoint: String, completion: @escaping (Result<UIImage,NetworkError>) -> ()){
    
        guard let url = URL(string: thumbnailEndpoint) else {
            completion(.failure(.badURL(thumbnailEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
}
