//
//  ElementApi.swift
//  Elements
//
//  Created by Jason on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
/*
 name
 symbol
number
weight
melting point
boiling point
discovery by
*/

struct Element: Codable{
    let name: String
    let symbol: String
    let number: Int
    let atomic_mass: Double
    let melt: Double?
    let boil: Double?
    let discovered_by: String?
}
