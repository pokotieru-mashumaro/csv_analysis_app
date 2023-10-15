//
//  csv_analysis_appApp.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/06.
//

import SwiftUI
import SwiftData

@main
struct csv_analysis_appApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Questions.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(QuestionsViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
