//
//  Element.swift
//  Elements
//
//  Created by Jose Alarcon Chacon on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    var name: String
    var category: String
    var atomic_mass: Double
    var number: Int
    var melt: Double?
    var boil: Double?
    var symbol: String
    var summary: String
   
}
