//
//  Element.swift
//  Elements
//
//  Created by Pritesh Nadiadhara on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomic_mass: Double
    let symbol: String
    let number: Int
    let discovered_by: String?
    let boil: Double?
    let melt: Double?
    let spectral_img: URL?
}



