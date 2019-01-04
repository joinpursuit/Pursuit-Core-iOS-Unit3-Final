//
//  ElementAPIClient.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
////
//
//import Foundation
//
////class ElementApiClient {
//
//
//
////    static func getElement(completionHandler: @escaping (AppError?, [Elements]?) -> Void) {
////        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements",
////            httpMethod:"GET",
////            httpBody: nil)
////        { (appError, data, httpResponse) in
////
////            if let appError = appError{
////                completionHandler(appError, nil)
////                print("appError")
////            }
////            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
////                let statusCode = httpResponse?.statusCode ?? -999
////                completionHandler(AppError.badStatusCode(String(statusCode)), nil)
////                print("response")
////                return
////            }
////
////            if let data = data {
////                do {
////                    let element = try JSONDecoder().decode([Elements].self, from: data)
////                    completionHandler(nil, element)
////                    print("WE GOT DATA")
////                } catch {
////                    print("Catch: \(error)")
////                    completionHandler(AppError.decodingError(error), nil)
////                }
////            }
////        }
////    }
//
//
//
//
//class ElementApiClient {
//
//    static let manager = ElementApiClient()
//
//    func getElement(completionHandler: @escaping (Error?, [Elements]?) -> Void) {
//        let urlString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
//        guard let url = URL(string: urlString) else {
//            completionHandler("bad url: \(urlString)" as? Error, nil)
//            return
//        }
//        URLSession.shared.dataTask(with: url){(data, response, error) in
//            print("#url:\(url)")
//            if let response = response {
//                print("#response code:\(response)")
//            }
//
//
//            if let error = error {
//                completionHandler(error, nil)
//                print(error, "#I'm here now")
//
//            } else if let data = data {
//                do {
//                    let results = try JSONDecoder().decode([Elements].self, from: data)
//                    let elements = results
//                    completionHandler(nil, elements)
//                    print("#WE GOT DATA")
//                } catch {
//                    print("#in the catch")
//                    completionHandler(error, nil)
//                }
//            }
//            }.resume()
//    }
//}
//
