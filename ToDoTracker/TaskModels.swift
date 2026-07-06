//
//  TaskModels.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: String(localized: "School", locale: .current), symbolName: "book.fill", tasks: [
            TaskItem(title: String(localized: "Do homework", locale: .current), isCompleted: true),
            TaskItem(title: String(localized: "Do exams", locale: .current), isCompleted: true),
            TaskItem(title: "", isCompleted: true),
            TaskItem(title: "", isCompleted: true),
            TaskItem(title: "")
        ]),
        TaskGroup(title: String(localized: "Home", locale: .current), symbolName: "house.fill", tasks: [
            TaskItem(title: String(localized: "Buy groceries", locale: .current), isCompleted: true),
            TaskItem(title: String(localized: "Clean dishes", locale: .current))
        ])
    ]

    static func sampleData(locale: Locale) -> [TaskGroup] {
        [
            TaskGroup(title: String(localized: "School", locale: locale), symbolName: "book.fill", tasks: [
                TaskItem(title: String(localized: "Do homework", locale: locale), isCompleted: true),
                TaskItem(title: String(localized: "Do exams", locale: locale), isCompleted: true),
                TaskItem(title: "", isCompleted: true),
                TaskItem(title: "", isCompleted: true),
                TaskItem(title: "")
            ]),
            TaskGroup(title: String(localized: "Home", locale: locale), symbolName: "house.fill", tasks: [
                TaskItem(title: String(localized: "Buy groceries", locale: locale), isCompleted: true),
                TaskItem(title: String(localized: "Clean dishes", locale: locale))
            ])
        ]
    }

    static func isDefaultSampleData(_ groups: [TaskGroup]) -> Bool {
        matchesSampleData(groups, locale: Locale(identifier: "en_US")) ||
        matchesSampleData(groups, locale: Locale(identifier: "es_ES")) ||
        matchesSampleData(groups, locale: Locale(identifier: "fr_FR"))
    }

    private static func matchesSampleData(_ groups: [TaskGroup], locale: Locale) -> Bool {
        let sample = sampleData(locale: locale)

        guard groups.count == sample.count else { return false }

        return zip(groups, sample).allSatisfy { group, sampleGroup in
            group.title == sampleGroup.title &&
            group.symbolName == sampleGroup.symbolName &&
            group.tasks.map(\.title) == sampleGroup.tasks.map(\.title) &&
            group.tasks.map(\.isCompleted) == sampleGroup.tasks.map(\.isCompleted)
        }
    }
}
