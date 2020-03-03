//
//  RocketLaunchList.swift
//  RocketLaunchLibrary
//
//  Created by Ihor on 24.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation
import CoreData

final class RocketLaunchList: NSManagedObject, Decodable {
    
    @NSManaged var launches: NSOrderedSet
    
    var launchesArray: [RocketLaunch] {
        return launches.array as? [RocketLaunch] ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case launches
    }
    
    convenience init(from decoder: Decoder) throws {
        guard let managedObjectContextKey = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "RocketLaunchList", in: managedObjectContext) else {
            fatalError("Failed to decode RocketLaunchList")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        launches = try NSOrderedSet(array: container.decode([RocketLaunch].self, forKey: .launches))
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketLaunchList> {
        return NSFetchRequest<RocketLaunchList>(entityName: "RocketLaunchList")
    }
}
