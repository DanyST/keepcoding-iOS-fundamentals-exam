//
//  NetworkError.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case malFormedUrl
    case decodingFailed
    case encodingFailed
    case noData
    case statusCode(code: Int?)
    case noToken
}
