//
//  Element.swift
//  Elements
//
//  Created by Leandro Wauters on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let symbol: String
    let number: Int
    let atomicMass: Double
    let melt: Double?
    let boil: Double?
    let discoveredBy: String?
    private enum CodingKeys: String, CodingKey{
        case name
        case symbol
        case number
        case atomicMass = "atomic_mass"
        case melt
        case boil
        case discoveredBy = "discovered_by"
    }
}
