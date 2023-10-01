//
//  Transformation.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

struct Transformation: Decodable {
    let id: String
    let photo: URL
    let description: String
    let name: String
}

extension Transformation: CharacterInfoDetailRepresentable {}
