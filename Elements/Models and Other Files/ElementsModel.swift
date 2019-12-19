//
//  ElementsModel.swift
//  Elements
//
//  Created by Yuliia Engman on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let appearance: String?
    let atomicMass: Double
    let boil: Double?
    let category: String
    let color: String?
    let density: Double?
    let discoveredBy: String?
    let melt: Double?
    let molarHeat: Double?
    let namedBy: String?
    let number: Int
    let period: Int
    let phase: Phase
    let source: String
    let spectralImg: String?
    let summary: String
    let symbol: String
    let favoritedBy: String?

    enum CodingKeys: String, CodingKey {
        case name, appearance
        case atomicMass = "atomic_mass"
        case boil, category, color, density
        case discoveredBy = "discovered_by"
        case melt
        case molarHeat = "molar_heat"
        case namedBy = "named_by"
        case number, period, phase, source
        case spectralImg = "spectral_img"
        case summary, symbol
        case favoritedBy
    }
    
    enum Phase: String, Codable {
        case gas = "Gas"
        case liquid = "Liquid"
        case solid = "Solid"
    }
}


//struct PodcastSearch: Codable {
//    let results: [Podcast]
//}
//
//struct Podcast: Codable {
//    let artistName: String?
//    let trackName: String?
//    let collectionName: String // we doing search on it
//    //let genres: [String]
//    let artworkUrl100: String? // URL image more main VC
//    let artworkUrl600: String // URL image
//    let trackId: Int?
//    let favoritedBy: String?
//}


//"id": "39",
//    "number": 70,
//    "phase": "Solid",
//    "atomic_mass": 173.0451,
//    "symbol": "Yb",
//    "boil": 1469,
//    "favoritedBy": "Luba",
//    "discovered_by": "Jean Charles Galissard de Marignac",
//    "melt": 1097,
//    "name": "Ytterbium"
