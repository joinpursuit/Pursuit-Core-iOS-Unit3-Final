//
//  ElementModel.swift
//  Elements
//
//  Created by Tanya Burke on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Results:Codable{
    var results: [Element]
}
struct Element:Codable {
    var name: String
    var appearance: String
    var atomicMass:Double
    var boil: Double
    let category: String
    let density: Double
    let discoveredBy: String
    let melt: Double
    let namedBy: String
    let number, period: Int
    let phase: String
    let source: String
    let spectralImg: String
    let symbol: String
    

    enum CodingKeys: String, CodingKey {
        case atomicMass = "atomic_mass"
        case discoveredBy = "discovered_by"
        case namedBy = "named_by"
        case spectralImg = "spectral_img"
       
    }
}
