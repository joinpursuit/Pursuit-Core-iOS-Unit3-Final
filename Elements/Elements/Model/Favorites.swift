//
//  Favorites.swift
//  Elements
//
//  Created by Matthew Huie on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let favoritedBy: String
    let elementName: String
    let elementSymbol: String
}
