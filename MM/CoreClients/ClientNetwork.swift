//
//  ClientNetwork.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

protocol ClientNetwork {
    var decoder: JSONDecoder { get }
    func request<T: Decodable>(_ type: T.Type, on service: NetworkService) async throws -> T
}
