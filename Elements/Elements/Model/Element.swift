//
//  Element.swift
//  Elements
//
//  Created by Jane Zhu on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let symbol: String
    let discovered_by: String?
    let number: Int
    let atomic_mass: Double
    let boil: Double?
    let melt: Double?
}

struct formatElementNumber {
    static func elementNumberWithThreeDigits(element: Element) -> String {
        if element.number < 10 {
            return "00\(element.number.description)"
        } else if element.number < 100 {
            return "0\(element.number.description)"
        } else {
            return element.number.description
        }
    }
}
