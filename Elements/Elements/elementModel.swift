//
//  Model.swift
//  Elements
//
//  Created by Tia Lendor on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


//Name
//Symbol(Number) Atomic Weight

//struct Elements: Codable {
//
//    let results: [ElementInfo]
//}

struct Elements: Codable {
    
    let name: String
    let atomic_mass: Double
    let boil: Double?
    let discovered_by: String?
    let melt: Double?
    let number: Int
    let symbol: String
    
    
}
