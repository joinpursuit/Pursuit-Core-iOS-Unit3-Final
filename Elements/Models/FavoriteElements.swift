//
//  FavoriteElements.swift
//  Elements
//
//  Created by Oscar Victoria Gonzalez  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct FavoriteElements: Codable {
    let symbol: String
    let number: Int
    let atomic_mass: Double
    let favoritedBy: String
    let melt: Double?
    let boil: Double?
    let discovered_by: String?
}


