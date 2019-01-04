//
//  ElementsModel.swift
//  Elements
//
//  Created by Elizabeth Peraza  on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Elements: Codable {
  
  let name: String
  let atomic_mass: Double
  //  let boil: Double //- decoding error "Expected Double value but found null instead: underlying error: nil)
//  let discovered_by: String // decoding error: valueNotFound(Swift.String, Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "Index 12", intValue: 12), CodingKeys(stringValue: "discovered_by", intValue: nil)], debugDescription: "Expected String value but found null instead.", underlyingError: nil))
//  let melt: Double // decoding error: valueNotFound(Swift.Double, Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "Index 5", intValue: 5), CodingKeys(stringValue: "melt", intValue: nil)], debugDescription: "Expected Double value but found null instead.", underlyingError: nil))
  let number: Int
  let summary: String
  let symbol: String
  
}


