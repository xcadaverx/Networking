//
//  MockURLSession.swift
//  NetworkingTests
//
//  Created by Daniel Williams on 4/28/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

final class MockURLSession: URLSession {
    
    typealias Completion = (Data?, URLResponse?, Swift.Error?) -> Void
    
    var data: Data?
    var response: URLResponse?
    var error: Swift.Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        
        return MockURLSessionDataTask { [data, response, error] in
            completionHandler(data, response, error)
        }
    }
}

final class MockURLSessionDataTask: URLSessionDataTask {
    
    private let _resume: () -> Void
    
    init(resume: @escaping () -> Void) {
        self._resume = resume
    }
    
    override func resume() {
        _resume()
    }
}
