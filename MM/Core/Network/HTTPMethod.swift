//
//  HTTPMethod.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

enum HTTPMethod {
    case get
    
    var string: String {
        switch self {
        case .get:
            return "GET"
        }
    }
    
    /* add as needed
     post, put, delete, patch
     */
}
