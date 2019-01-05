//
//  Element.swift
//  Elements
//
//  Created by Oniel Rosario on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct Element: Codable {
    let name: String
    let atomic_mass: Double
    let boil: Double?
    let density: Double?
    let discovered_by: String?
    let melt: Double?
    let number: Int
    let summary: String
    let symbol: String
}
