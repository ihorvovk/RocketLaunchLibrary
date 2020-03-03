//
//  Rocket.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 2/17/20.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation
import CoreData

final class Rocket: NSManagedObject, Decodable {
    
    @NSManaged var id: Int
    @NSManaged var name: String?
    @NSManaged var imageURL: String?
    @NSManaged var wikiURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL
        case wikiURL
    }
    
    convenience init(from decoder: Decoder) throws {
        guard let managedObjectContextKey = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Rocket", in: managedObjectContext) else {
            fatalError("Failed to decode Rocket")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        wikiURL = try container.decode(String.self, forKey: .wikiURL)
    }
}
