//
//  Element.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let symbol: String
    let spectral_img: URL?
    let discovered_by: String?
    let number: Int
    let atomic_mass: Double
    let boil: Double?
    let melt: Double?
}
