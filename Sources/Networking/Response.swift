//
//  Response.swift
//  Networking
//
//  Created by Daniel Williams on 4/21/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

public struct Response<Body> {
    
    public let statusCode: Int
    public let body: Body
}
