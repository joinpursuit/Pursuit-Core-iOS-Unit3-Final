//
//  Favorites.swift
//  Elements
//
//  Created by Genesis Mosquera on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Favorites: Codable {
    let favoritedBy: String
    let elementName: String
    let elementSymbol: String
    let spectral_img: URL
}
