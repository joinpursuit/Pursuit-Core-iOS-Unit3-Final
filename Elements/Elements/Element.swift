//
//  Element.swift
//  Elements
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

// MARK: Element Model
struct Element: Codable{
    var name: String?
    var appearance: String?
    var atomicMass: Double?
    var boil: Double?
    var category: String?
    var colour: String?
    var density: Double?
    var discoveredBy: String?
    var melt: Double?
    var molarHeat: Double?
    var namedBy: String?
    var number: Int?
    var period: Int?
    var phase: String?
    var source: String?
    var spectralImage: String?
    var summary: String?
    var symbol: String?
    var favouritedBy: String?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case appearance = "appearance"
        case atomicMass = "atomic_mass"
        case boil = "boil"
        case category = "category"
        case colour = "color"
        case density = "density"
        case discoveredBy = "discovered_by"
        case melt = "melt"
        case molarHeat = "molar_heat"
        case namedBy = "named_by"
        case number = "number"
        case period = "period"
        case phase = "phase"
        case source = "source"
        case spectralImage = "spectral_img"
        case summary = "summary"
        case symbol = "symbol"
    }
}
