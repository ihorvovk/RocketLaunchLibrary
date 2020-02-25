//
//  RocketLaunch.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 2/17/20.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

struct RocketLaunch: Decodable {
    
    let id: Int
    let name: String
    let net: Date?
    let windowStart: Date?
    let windowEnd: Date?
    let country: String?
    let status: Int?
    
    let rocket: Rocket?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case net
        case windowStart
        case windowEnd
        case country
        case status
        case rocket
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        net = try? container.decode(Date.self, forKey: .net)
        windowStart = try? container.decode(Date.self, forKey: .windowStart)
        windowEnd = try? container.decode(Date.self, forKey: .windowEnd)
        country = try? container.decode(String.self, forKey: .country)
        status = try? container.decode(Int.self, forKey: .status)
        
        rocket = try? container.decode(Rocket.self, forKey: .rocket)
    }
}
