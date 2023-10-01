//
//  LocalDataModelTests.swift
//  SuperHeroesTests
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import XCTest
@testable import SuperHeroes

final class LocalDataModelTests: XCTestCase {
    var sut: LocalDataModel!
    
    override func setUp() {
        super.setUp()
        let userDefaults = UserDefaults(suiteName: "LocalDataModelTests")!
        sut = LocalDataModel(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSaveToken() {
        let mockToken = "123456789"
        sut.save(token: mockToken)
        
        XCTAssertNotNil(sut.getToken())
        XCTAssertEqual(sut.getToken(), mockToken)
    }
    
    func testDeleteToken() {
        let mockToken = "123456789"
        sut.save(token: mockToken)
        sut.deleteToken()
        XCTAssertNil(sut.getToken())
        XCTAssertNotEqual(sut.getToken(), mockToken)
    }
}
