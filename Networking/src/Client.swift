//
//  Client.swift
//  Networking
//
//  Created by Daniel Williams on 4/21/19.
//  Copyright © 2019 MakeBestFriends. All rights reserved.
//

import Foundation

public struct Client {
    
    public typealias Completion = (Result<Response<Data>, Swift.Error>) -> Void
    
    private let session: URLSession
    private let baseURL: URL
    
    public init(baseURL: URL, session: URLSession = .shared) {
        
        self.baseURL = baseURL
        self.session = session
    }
    
    public func perform(_ request: Request, _ completion: @escaping Completion) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(.failure(Error.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        request.headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.field)
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(Error.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(Error.noData))
                return
            }
            
            let response = Response<Data>(statusCode: httpResponse.statusCode, body: data)
            completion(.success(response))
        }
        
        task.resume()
    }
}
