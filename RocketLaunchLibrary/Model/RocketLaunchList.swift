//
//  RocketLaunchList.swift
//  RocketLaunchLibrary
//
//  Created by Ihor on 24.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

struct RocketLaunchList: Decodable {
    
    let launches: [RocketLaunch]
    
    enum CodingKeys: String, CodingKey {
        case launches
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        launches = try container.decode([RocketLaunch].self, forKey: .launches)
    }
}
