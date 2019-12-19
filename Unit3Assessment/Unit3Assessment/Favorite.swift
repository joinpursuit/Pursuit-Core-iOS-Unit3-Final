//
//  Favorite.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let id: String?
    let category: String?
    let melt: Double?
    let boil: Double?
    let period: Int?
    let symbol: String
    let discoveredBy: String?
    let molarHeat: Double?
    let phase: String?
    let source: String?
    let summary: String?
    let favoritedBy: String
    let number: Int
    let appearance: String?
    let density: Double?
    let atomicMass: Double?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case category = "category"
        case melt = "melt"
        case boil = "boil"
        case period = "period"
        case symbol = "symbol"
        case discoveredBy = "discovered_by"
        case molarHeat = "molar_heat"
        case phase = "phase"
        case source = "source"
        case summary = "summary"
        case favoritedBy = "favoritedBy"
        case number = "number"
        case appearance = "appearance"
        case density = "density"
        case atomicMass = "atomic_mass"
        case name = "name"
    }
}
