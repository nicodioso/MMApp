//
//  NetworkService.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

protocol NetworkService {
    var url: URL { get }
    var method: HTTPMethod { get }
    
        //..
}
