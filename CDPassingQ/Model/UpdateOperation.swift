//
//  UpdateOperation.swift
//  CDPassingQ
//
//  Created by ericg on 3/6/22.
//

import Foundation
import CoreData

struct UpdateOperation<Object: NSManagedObject>: Identifiable {
  let id = UUID()
  let childContext: NSManagedObjectContext
  let childObject:  Object
  
  init( withExistingObject  object:         Object,
        in                  parentContext:  NSManagedObjectContext ) {
    let childContext    = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    childContext.parent = parentContext
    let childObject     = childContext.object(with: object.objectID) as! Object
    
    self.childContext = childContext
    self.childObject  = childObject
  }
}
