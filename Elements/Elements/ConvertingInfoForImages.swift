//
//  ConvertingInfoForImages.swift
//  Elements
//
//  Created by Tia Lendor on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsDetailsForImages: Codable {
    
    let name: String
    let number: Int
    
    func getThumbnail(from data: Data) -> String {
        if number <= 9 {
            return "00\(number)"
        }else if number <= 99 {
            return "0\(number)"
        }
        return "\(number)"
    }
    
    func getElementImage(from data: Data) -> String {
        return name.lowercased()
    }
    
    
    
    
    
}
