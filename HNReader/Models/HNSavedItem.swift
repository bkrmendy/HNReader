//
//  HNSavedItem.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 25..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import UIKit
import CoreData

class HNSavedItem: NSManagedObject {
    static func findOrCreateItem(matching id: Int, in context: NSManagedObjectContext) throws -> HNSavedItem {
        let request: NSFetchRequest<HNSavedItem> = HNSavedItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", String(id))
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
        }
        catch {
            throw error
        }
        
        let savedItem = HNSavedItem(context: context)
        savedItem.id = String(id)
        savedItem.added = NSDate()
        return savedItem
    }
}
