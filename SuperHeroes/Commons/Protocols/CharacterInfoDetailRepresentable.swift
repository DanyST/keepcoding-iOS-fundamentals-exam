//
//  CharacterInfoDetailRepresentable.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

protocol CharacterInfoDetailRepresentable {
    var name: String { get }
    var description: String { get }
    var photo: URL { get }
}
