//
//  Element.swift
//  Elements
//
//  Created by Matthew Ramos on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    
    let name: String
    let symbol: String
    let number: Int
    let atomic_mass: Double
    let melt: Double?
    let boil: Double?
    let discovered_by: String?
}
