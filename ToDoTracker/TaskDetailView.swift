//
//  TaskDetailView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import Combine
import SwiftUI

struct TaskDetailView: View {
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.locale) private var locale
    @AppStorage("appLanguage") private var appLanguage = AppLanguage.system.rawValue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 52) {
                VStack(alignment: .leading, spacing: 30) {
                    LocaleResourceHeader(
                        language: AppLanguage(rawValue: appLanguage) ?? .system,
                        locale: locale
                    ) {
                        addTask()
                    }

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
                    addTask()
                } label: {
                    Label("Add Task", systemImage: "plus")
                }
            }
        }
    }

    private func addTask() {
        withAnimation {
            group.tasks.append(TaskItem(title: ""))
        }
    }
    
    private struct LocaleResourceHeader: View {
        let language: AppLanguage
        let locale: Locale
        let addTask: () -> Void
        @State private var currentDate = Date()

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Image(language.resourceImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 132)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .accessibilityLabel(Text("Localized background image"))

                VStack(alignment: .leading, spacing: 10) {
                    Text("Organize tasks for your region")
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text("Dates, time, numbers, and visual resources update when the app language changes.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    LocaleFormatGrid(locale: locale, currentDate: currentDate)

                    Button(action: addTask) {
                        Label("Add a task now", systemImage: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                }
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .onReceive(Timer.publish(every: 60, on: .main, in: .common).autoconnect()) { value in
                currentDate = value
            }
        }
    }

    private struct LocaleFormatGrid: View {
        let locale: Locale
        let currentDate: Date

        var body: some View {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 8) {
                GridRow {
                    Text("Today")
                        .fontWeight(.medium)
                    Text(formattedDate)
                }

                GridRow {
                    Text("Current time")
                        .fontWeight(.medium)
                    Text(formattedTime)
                }

                GridRow {
                    Text("Example number")
                        .fontWeight(.medium)
                    Text(formattedNumber)
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        }

        private var formattedDate: String {
            let formatter = DateFormatter()
            formatter.locale = locale
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            return formatter.string(from: currentDate)
        }

        private var formattedTime: String {
            let formatter = DateFormatter()
            formatter.locale = locale
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter.string(from: currentDate)
        }

        private var formattedNumber: String {
            let formatter = NumberFormatter()
            formatter.locale = locale
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            return formatter.string(from: 12345.67) ?? "12,345.67"
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
