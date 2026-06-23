//
//  TaskModels.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import Foundation

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted = false
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: String(localized: "School"), symbolName: "book.fill", tasks: [
            TaskItem(title: String(localized: "Do homework")),
            TaskItem(title: String(localized: "Do exams"))
        ]),
        TaskGroup(title: String(localized: "Home"), symbolName: "house.fill", tasks: [
            TaskItem(title: String(localized: "Buy groceries"), isCompleted: true),
            TaskItem(title: String(localized: "Clean dishes"))
        ])
    ]
}
