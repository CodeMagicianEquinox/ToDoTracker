//
//  ToDoTrackerApp.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

@main
struct ToDoTrackerApp: App {
    @AppStorage("appLanguage") private var appLanguage = AppLanguage.system.rawValue

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, AppLanguage(rawValue: appLanguage)?.locale ?? .autoupdatingCurrent)
        }
    }
}
