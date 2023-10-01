//
//  Hero.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import Foundation

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}
