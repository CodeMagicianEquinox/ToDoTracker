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
            let language = AppLanguage(rawValue: appLanguage) ?? .system

            ContentView()
                .environment(\.locale, language.locale)
                .environment(\.layoutDirection, language.layoutDirection)
        }
    }
}
