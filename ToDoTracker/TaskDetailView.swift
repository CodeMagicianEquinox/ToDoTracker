//
//  TaskDetailView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 52) {
                VStack(alignment: .leading, spacing: 30) {
                    Text(group.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Section{
                        if sizeClass == .regular {
                            GroupStatsView(tasks: group.tasks)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color(.secondarySystemBackground))
                        }
                    }
                    
                    VStack(spacing: 0) {
                        ForEach(group.tasks.indices, id: \.self) { index in
                            TaskRow(task: $group.tasks[index])
                            
                            if index < group.tasks.count - 1 {
                                Divider()
                                    .padding(.leading, 28)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .shadow(color: .black.opacity(0.03), radius: 18, x: 0, y: 10)
                }
                .padding(.horizontal, sizeClass == .regular ? 24 : 18)
                .padding(.top, 50)
                .padding(.bottom, 36)
                .frame(maxWidth: sizeClass == .regular ? 690 : .infinity, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(red: 0.96, green: 0.94, blue: 0.98))
            .navigationTitle(group.title)
            .navigationBarTitleDisplayMode(.inline)
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
    
    private struct TaskRow: View {
        @Binding var task: TaskItem
        
        var body: some View {
            HStack(spacing: 10) {
                Button {
                    withAnimation {
                        task.isCompleted.toggle()
                    }
                } label: {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(task.isCompleted ? .purple : .gray)
                        .frame(width: 18, height: 18)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(
                    task.isCompleted
                    ? String(localized: "Mark incomplete")
                    : String(localized: "Mark complete")
                )
                
                TextField("Task Title", text: $task.title, prompt: Text("Task Title").foregroundStyle(.gray.opacity(0.45)))
                    .font(.body)
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? .gray : .primary)
                    .textFieldStyle(.plain)
            }
            .frame(height: 47)
        }
    }
}
