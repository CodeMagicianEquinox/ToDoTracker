//
//  TaskDetailView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var group: TaskGroup
    
    var body: some View {
        List {
            ForEach($group.tasks) { $task in
                HStack {
                    Button {
                        withAnimation {
                            task.isCompleted.toggle()
                        }
                    } label: {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(task.isCompleted ? .purple : .gray)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(
                        task.isCompleted
                            ? String(localized: "Mark incomplete")
                            : String(localized: "Mark complete")
                    )
                    
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                }
            }
            .onDelete { index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button {
                withAnimation {
                    group.tasks.append(TaskItem(title: ""))
                }
            } label: {
                Label("Add Task", systemImage: "plus")
            }
        }
    }
}
