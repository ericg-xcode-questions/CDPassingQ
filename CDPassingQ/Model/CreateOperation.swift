//
//  CreateOperation.swift
//  CDPassingQ
//
//  Created by ericg on 3/6/22.
//

import Foundation
import CoreData

struct CreateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    
    let childContext:   NSManagedObjectContext
    let childObject:    Object
    
    init(with parentContext: NSManagedObjectContext) {
        let childContext    = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = parentContext
        let childObject     = Object(context: childContext)
        
        self.childContext   = childContext
        self.childObject    = childObject
    }
}
