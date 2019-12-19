//
//  ElementModel.swift
//  Elements
//
//  Created by Liubov Kaper  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementInfo: Codable {
    
    let name: String
    let atomic_mass: Double
    let discovered_by: String?
    let melt: Double?
    let number: Int
    let phase: String
    let symbol: String
    let boil: Double?
    let favoritedBy: String
}



