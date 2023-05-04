//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Linda Bergsängel on 2023-05-04.
//

import SwiftUI
import Firebase

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
