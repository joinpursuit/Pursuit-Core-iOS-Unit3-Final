//
//  ElementDecodedModel.swift
//  Elements
//
//  Created by Ashli Rankin on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Elements:Codable{
  let results: [Element]
}
struct Element:Codable {
  let name:String
  let atomic_mass:Double
  let number:Int
  let boil:Double?
  let melt: Double?
  let discovered_by:String?
  let symbol:String
  
}
