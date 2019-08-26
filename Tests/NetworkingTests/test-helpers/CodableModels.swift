//
//  DecodableModels.swift
//  NetworkingTests
//
//  Created by Daniel Williams on 4/28/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

// Just a helper model used for tests
struct Twelve: Codable {
    
    let value: Int = 12
    let spelling: String = "twelve"
    
    static let dataRepresentation: Data = """
    {
        "value": 12,
        "spelling": "twelve"
    }
    """.data(using: .utf8)!
}
