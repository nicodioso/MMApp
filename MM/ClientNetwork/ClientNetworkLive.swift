//
//  ClientNetworkLive.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

class ClientNetworkLive: ClientNetwork {
    
    static let shared = ClientNetworkLive()
    
    let urlSession = URLSession.shared
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func request<T: Decodable>(_ type: T.Type, on service: NetworkService) async throws -> T {
        var urlRequest = URLRequest(url: service.url)
        urlRequest.httpMethod = service.method.string
        let (data, _) = try await urlSession.data(for: urlRequest)
        if let data = data as? T {
            return data
        } else {   
            return try decoder.decode(T.self, from: data)
        }
    }
}
