//
//  LocalDataModel.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import Foundation

struct LocalDataModel {
    private static let tokenKey = "SuperHeroesToken"
    
    // It is not a good practice to use UserDefaults to store sensitive data; for this case, KeyChain is highly recommended. In the next module of the mobile bootcamp, we will use KeyChain to store sensitive data, such as the token.
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: tokenKey)
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
