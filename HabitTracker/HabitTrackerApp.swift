//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-05-03.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
