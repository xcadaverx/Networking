//
//  Request.swift
//  Networking
//
//  Created by Daniel Williams on 4/21/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

public class Request {

    public let method: Method
    public let path: String
    public var queryItems: [URLQueryItem]?
    public var headers: Set<Header> = []
    public var body: Data?
    
    public init(method: Method, path: String) {

        self.method = method
        self.path = path
    }
    
    public init<Body: Encodable>(method: Method, path: String, body: Body) throws {

        self.method = method
        self.path = path
        self.body = try JSONEncoder().encode(body)
    }
}
