//
//  LocalDataModelProtocol.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

protocol LocalDataModelProtocol {
    func getToken() -> String?
    func save(token: String)
    func deleteToken() 
}
