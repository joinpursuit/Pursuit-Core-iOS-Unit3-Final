//
//  NetworkError.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

// Custom Error type for URLSession calls.
enum NetworkError: Error{
    case noData
    case badURL(String)
    case networkClientError(Error)
    case noResponse
    case badStatusCode(Int)
    case encodingError(Error)
    case decodingError(Error)
}
