//
//  Element.swift
//  Elements
//
//  Created by Chelsi Christmas on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    var name: String
    var atomic_mass: Double
    var number: Int
    var symbol: String
    var boil: Double?
    var melt: Double?
    var discovered_by: String?
}

