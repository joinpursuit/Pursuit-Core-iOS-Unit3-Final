//
//  Elements.swift
//  Elements
//
//  Created by Joshua Viera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

//struct Elements: Codable {
//    var atomic_mass: Double
//    var boil: Double
//    var discovered_by: String
//    var melt: Double
//    var number: Double
//    var symbol: String
//}
//
struct Element: Codable {
    let name: String
    let number: Int
    let atomicMass: Double
    let boil: Double?
    let discoveredBy: String?
    let melt: Double?
    let symbol: String
    private enum CodingKeys: String, CodingKey {
        case name
        case number
        case atomicMass = "atomic_mass"
        case boil
        case discoveredBy = "discovered_by"
        case melt
        case symbol
    }
}
