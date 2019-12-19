//
//  ChemistryElement.swift
//  Unit3Assessment
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let category: String
    let symbol: String
    let number: Int
    let period: Int
    let phase: String
    let source: String
    let atomicMass: Double
    let appearance: String?
    let summary: String
    let molarHeat: Double?
    let melt: Double?
    let boil: Double?
    let discoveredBy: String?
    let density: Double?
    
    var elementNumberInString: String {
        return number / 100 == 0 ?
            (number / 10 == 0 ? "00\(number)" : "0\(number)") : "\(number)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, category, number, symbol, period, phase
        case summary, appearance, density
        case atomicMass = "atomic_mass"
        case melt, boil, source
        case discoveredBy = "discovered_by"
        case molarHeat = "molar_heat"
    }
}
