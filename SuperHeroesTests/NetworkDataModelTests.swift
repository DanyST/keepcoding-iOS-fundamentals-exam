//
//  NetworkDataModelTests.swift
//  SuperHeroesTests
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import XCTest
@testable import SuperHeroes

final class NetworkDataModelTests: XCTestCase {
    // sut = subject under test
    private var sut: NetworkDataModel<LocalDataModel>!
    
    override func setUp()  {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkDataModel(session: session)
        MockURLProtocol.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        MockURLProtocol.error = nil
    }
    
    func testLoginSuccess() throws {
        let expectedToken = "Some Token"
        let someUser = "someUser"
        let somePassword = "somePassword"
        
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser, somePassword)
            let loginData = loginString.data(using: .utf8)!
            let base64LogingString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Basic \(base64LogingString)"
            )
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"]
                )
            )
            return (response, data)
        }
        
        let expectation = expectation(description: "Login success")
        
        sut.login(
            user: someUser,
            password: somePassword,
            completion: { result in
                guard case let .success(token) = result else {
                    XCTFail("Expected success but received \(result)")
                    return
                }
                
                XCTAssertEqual(token, expectedToken)
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoginFailure() {
        let someUser = "someUser"
        let somePassword = "somePassword"
        
        MockURLProtocol.error = .unknown
        
        let expectation = expectation(description: "Login failure")
    
        sut.login(
            user: someUser,
            password: somePassword,
            completion: { result in
                guard case let .failure(error) = result else {
                    XCTFail("Expected failure but received \(result)")
                    return
                }
                
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .unknown)
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 1)
    }
}
