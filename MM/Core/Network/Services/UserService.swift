//
//  UserService.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

enum UserService: NetworkService {
    
    case getAll
    
    var url: URL {
        switch self {
        case .getAll:
            return URL(string: "https://api.github.com/users")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
}
