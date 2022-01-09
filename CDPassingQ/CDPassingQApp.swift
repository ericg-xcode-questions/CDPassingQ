//
//  CDPassingQApp.swift
//  CDPassingQ
//
//  Created by ericg on 1/9/22.
//

import SwiftUI

@main
struct CDPassingQApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
