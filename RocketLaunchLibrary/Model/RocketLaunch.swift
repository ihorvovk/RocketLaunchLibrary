//
//  RocketLaunch.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 2/17/20.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation
import CoreData

final class RocketLaunch: NSManagedObject, Decodable {
    
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var net: Date?
    @NSManaged var windowStart: Date?
    @NSManaged var windowEnd: Date?
    @NSManaged var country: String?
    @NSManaged var status: Int
    
    @NSManaged var rocket: Rocket?
    
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
    
    convenience init(from decoder: Decoder) throws {
        guard let managedObjectContextKey = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "RocketLaunch", in: managedObjectContext) else {
            fatalError("Failed to decode RocketLaunch")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        net = try? container.decode(Date.self, forKey: .net)
        windowStart = try? container.decode(Date.self, forKey: .windowStart)
        windowEnd = try? container.decode(Date.self, forKey: .windowEnd)
        country = try? container.decode(String.self, forKey: .country)
 //       status = try container.decode(Int.self, forKey: .status)
        
        rocket = try? container.decode(Rocket.self, forKey: .rocket)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketLaunch> {
        return NSFetchRequest<RocketLaunch>(entityName: "RocketLaunch")
    }
}
