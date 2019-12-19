//
//  ElementModel.swift
//  Elements
//
//  Created by Tanya Burke on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Results:Codable {
    var results: Element
}

struct Element:Codable {
    var name: String
    var appearance: String?
    var atomicMass:Double?
    var boil: Double?
    var category: String?
    var density: Double?
    var discoveredBy: String?
    var melt: Double?
    var namedBy: String?
    var number: Int
    var period: Int
    var phase: String
    var source: String
    var spectralImg: String?
    var symbol: String
    var summary: String
    var id: String?
    var favoritedBy: String?
    
}

    enum CodingKeys: String, CodingKey {
        case atomicMass = "atomic_mass"
        case discoveredBy = "discovered_by"
        case namedBy = "named_by"
        case spectralImg = "spectral_img"
       
    }

