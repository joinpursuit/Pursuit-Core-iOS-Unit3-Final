//
//  Elements.swift
//  Elements
//
//  Created by Kevin Waring on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomic_mass: Double
    let discovered_by: String?
    let boil: Double?
    let number: Int
    let symbol: String?
    let melt: Double?
    //let spectral_img: URL
    
}
