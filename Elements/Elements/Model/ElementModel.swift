//
//  ElementModel.swift
//  Elements
//
//  Created by Donkemezuo Raymond Tariladou on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct PeriodicTable: Codable {
    var elements: [Elements]
    
}
struct Elements: Codable{
    var name: String
    var atomic_mass: Double
    var boil: Double?
    var melt: Double?
    var discovered_by: String?
    var number: Int
    var symbol: String
}
