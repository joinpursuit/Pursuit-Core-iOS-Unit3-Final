//
//  Elements.swift
//  Elements
//
//  Created by Biron Su on 1/4/19.
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

struct Favorite: Codable {
    let favoritedBy: String
    let elementName: String
    let elementSymbol: String
}
