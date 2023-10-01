//
//  CellIdentifiable.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

protocol CellIdentifiable: UITableViewCell {
    static var identifier: String { get }
}
