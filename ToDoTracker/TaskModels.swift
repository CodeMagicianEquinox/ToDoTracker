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
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [
            TaskItem(title: "Do homework"),
            TaskItem(title: "Do exams")
        ]),
        TaskGroup(title: "Home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Buy groceries", isCompleted: true),
            TaskItem(title: "Clean dishes")
        ])
    ]
}
