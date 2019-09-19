//
//  Model.swift
//  Elements
//
//  Created by Tia Lendor on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation



struct Elements: Codable {
    
    let name: String
    let atomic_mass: Double
    let boil: Double?
    let discovered_by: String?
    let melt: Double?
    let number: Int
    let symbol: String
    

    
    
}

var numberForElementUrl: String

mutating func getNumberForElementImage (from data: Data) throws -> String {
    if number <= 9 {
        numberForElementUrl = "00\(number)"
        return numberForElementUrl
    }else if number < 90 {
        numberForElementUrl = "0\(number)"
        return numberForElementUrl
    }else {
        numberForElementUrl = "\(number)"
        return numberForElementUrl
    }
    
}
