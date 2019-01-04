//
//  Elements.swift
//  Elements
//
//  Created by Genesis Mosquera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementsData: Codable {
    let resultCount: Int
    let results: [Elements]
}

struct Elements: Codable {
    let name: String
    let atomic_mass: Float
    let boil: Float
    let discovered_by: String
    let melt: Float
    let number: Int
    let spectral_img: URL
    let symbol: String
}
