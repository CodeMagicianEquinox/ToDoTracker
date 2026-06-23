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
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .purple : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                    
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
            Button("Add Task +") {
                withAnimation {
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}
