//
//  Element.swift
//  Elements
//
//  Created by J on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Element: Codable {
  public let symbol: String
  public let number: Int
  public let atomic_mass: Double
  public let melt: Double?
  public let boil:Double?
  public let discovered_by: String?
  public let name: String
  public let category: String
  public var elementNumber:String {
    if number < 10 {
      return "00\(number)"
    } else if number < 100 {
      return "0\(number)"
    }
    return String(number)
  }
}
