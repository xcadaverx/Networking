//
//  Response+Decodable.swift
//  Networking
//
//  Created by Daniel Williams on 4/27/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

public extension Response where Body == Data {
    
    func decode<Model: Decodable>(to type: Model.Type) throws -> Model {
        
        let body = try JSONDecoder().decode(Model.self, from: self.body)
        return body
    }
}
