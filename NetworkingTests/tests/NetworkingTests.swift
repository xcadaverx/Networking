//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Daniel Williams on 4/27/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {
    
    private let mockBaseURL = URL(string: "http://www.mock.com")!
    
    private lazy var mockSession: MockURLSession = {
        let mock = MockURLSession()
        mock.response = HTTPURLResponse(
            url: mockBaseURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        return mock
    }()
    
    private lazy var request: Request = {
        let req = Request(method: .get, path: "/mock")
        req.headers = [Header(field: "Accept", value: "application/json")]
        return req
    }()
    
    private lazy var client = Client(baseURL: mockBaseURL, session: mockSession)
    
    override func setUp() {
        
        mockSession.data = nil
        mockSession.error = nil
    }
    
    func testModelIsDecoded() {
        
        let expectation = self.expectation(description: "should decode model")
        
        mockSession.data = Twelve.dataRepresentation
        client.perform(request) { result in
            switch result {
            case .success(let response):
                let twelve = try? response.decode(to: Twelve.self)
                XCTAssertEqual(twelve?.spelling, "twelve")
                XCTAssertEqual(twelve?.value, 12)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testEmptyResponseThrowsError() {
        
        let expection = self.expectation(description: "empty data should throw an error")
        
        mockSession.data = nil
        client.perform(request) { result in
            switch result {
            case .failure(let error as Error):
                XCTAssertEqual(error, Error.noData)
                expection.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testRequestBodyIsEncoded() {
        
        let twelve = Twelve()
        let request = try? Request(method: .get, path: "/mock", body: twelve)
        let encoded = try? JSONEncoder().encode(twelve)
        
        XCTAssertEqual(request?.body, encoded)
    }
    
    func testInvalidResponse() {
        
        let expectation = self.expectation(description: "url should be invalid and throw an error")
        
        mockSession.response = nil
        
        client.perform(request) { result in
            switch result {
            case .failure(let error as Error):
                XCTAssertEqual(error, Error.invalidResponse)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    func testSessionErrorIsCaught() {
        
        enum TestError: Swift.Error {
            case test
        }
        
        let expectation = self.expectation(description: "URLSession Error is caught")
        mockSession.error = TestError.test
        
        client.perform(request) { result in
            switch result {
            case .failure(let error as TestError):
                XCTAssertEqual(error, TestError.test)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 0.1)
    }
}
