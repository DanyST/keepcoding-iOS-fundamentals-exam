//
//  NetworkDataModelProtocol.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

protocol NetworkDataModelProtocol {
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    )
    func getHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void)
    func getTransformations(
        for hero: Hero,
        completion: @escaping (Result<[Transformation], NetworkError>) -> Void
    )
}
