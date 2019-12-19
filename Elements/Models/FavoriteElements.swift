//
//  FavoriteElements.swift
//  Elements
//
//  Created by Oscar Victoria Gonzalez  on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct FavoriteElements: Codable {
    let symbol: String
    let number: Int
    let atomic_mass: Double
    let favoritedBy: String
    let melt: Double?
    let boil: Double?
    let discovered_by: String?
}


//symbol
//number
//weight
//melting point
//boiling point
//discovery by

//{
//      "id": "10",
//      "category": "metalloid",
//      "melt": 1687,
//      "period": 3,
//      "symbol": "Si",
//      "boil": 3538,
//      "molar_heat": 19.789,
//      "discovered_by": "Jöns Jacob Berzelius",
//      "phase": "Solid",
//      "source": "https://en.wikipedia.org/wiki/Silicon",
//      "summary": "Silicon is a chemical element with symbol Si and atomic number 14. It is a tetravalent metalloid, more reactive than germanium, the metalloid directly below it in the table. Controversy about silicon's character dates to its discovery.",
//      "favoritedBy": "Howard",
//      "number": 14,
//      "appearance": "crystalline, reflective with bluish-tinged faces",
//      "density": 2.329,
//      "atomic_mass": 28.085,
//      "name": "Silicon"
//  }
