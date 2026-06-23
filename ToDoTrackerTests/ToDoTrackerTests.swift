//
//  ToDoTrackerTests.swift
//  ToDoTrackerTests
//
//  Created by Tim Terrance on 6/22/26.
//

import Testing
@testable import ToDoTracker

struct ToDoTrackerTests {

    @Test func sampleDataContainsUsableGroups() {
        let groups = TaskGroup.sampleData

        #expect(!groups.isEmpty)
        #expect(groups.allSatisfy { !$0.title.isEmpty })
        #expect(groups.allSatisfy { !$0.symbolName.isEmpty })
        #expect(groups.allSatisfy { !$0.tasks.isEmpty })
    }

    @Test func newTaskDefaultsToIncomplete() {
        let task = TaskItem(title: "Test task")

        #expect(task.title == "Test task")
        #expect(!task.isCompleted)
    }
}
