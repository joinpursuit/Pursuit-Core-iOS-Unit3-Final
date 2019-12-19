//
//  Element.swift
//  Elements
//
//  Created by Amy Alsaydi on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let discovered_by: String?
    let number: Int
    let melt: Double?
    let symbol: String
    let summary: String?
    let boil: Double?
    let atomic_mass: Double?
    let favoritedBy: String?
}
