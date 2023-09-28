//
//  User.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import Foundation

struct User: Codable, Identifiable {
    
    let id: Int
    let username: String
    let avatarUrl: String
    let profileUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, username = "login", avatarUrl, profileUrl = "htmlUrl"
    }
}
