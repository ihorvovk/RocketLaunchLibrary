//
//  Rocket.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 2/17/20.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
    
    let id: Int
    let name: String?
    let imageURL: String?
    let wikiURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL
        case wikiURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        wikiURL = try container.decode(String.self, forKey: .wikiURL)
    }
}
