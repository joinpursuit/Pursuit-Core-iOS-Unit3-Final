//
//  Element.swift
//  Elements
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let atomicMass: Double
    let namedBy: String?
    let number: Int
    let phase: String
    let summary: String
    let symbol: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case atomicMass = "atomic_mass"
        case namedBy = "named_by"
        case number
        case phase
        case summary
        case symbol
    }
}
