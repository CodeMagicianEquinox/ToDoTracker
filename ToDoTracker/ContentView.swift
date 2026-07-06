//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("appLanguage") private var appLanguage = AppLanguage.system.rawValue

    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    @State private var isShowingAddGroup = false
    let saveKey = "savedTaskGroupsKey"

    init() {
        let groups = TaskGroup.sampleData
        _taskGroups = State(initialValue: groups)
        _selectedGroup = State(initialValue: groups.first)
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            TaskGroupSidebar(
                taskGroups: taskGroups,
                selectedGroup: $selectedGroup,
                appLanguage: $appLanguage,
                isRegularWidth: horizontalSizeClass == .regular
            ) {
                isShowingAddGroup = true
            }
        } detail: {
            SelectedTaskGroupDetail(taskGroups: $taskGroups, selectedGroup: selectedGroup)
        }
        .navigationSplitViewStyle(.balanced)
        .tint(.black)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup // auto nav to the group selected
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .inactive || newValue == .background {
                saveData()
            }
        }
        .onChange(of: appLanguage) { oldValue, newValue in
            updateSampleDataForLanguage()
        }
        
    }

    // Convert Array -> JSON Data
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
            // what do you want to save, where
        }
    }

    // Look for stored JSON data -> Array
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            // look for available values
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedGroups
                selectedGroup = decodedGroups.first
                return
            }
        }

        let groups = localizedSampleData()
        taskGroups = groups
        selectedGroup = groups.first
    }

    private func updateSampleDataForLanguage() {
        guard TaskGroup.isDefaultSampleData(taskGroups) else { return }

        let groups = localizedSampleData()
        taskGroups = groups
        selectedGroup = groups.first
        saveData()
    }

    private func localizedSampleData() -> [TaskGroup] {
        let language = AppLanguage(rawValue: appLanguage) ?? .system
        return TaskGroup.sampleData(locale: language.sampleDataLocale)
    }
}

private struct TaskGroupSidebar: View {
    let taskGroups: [TaskGroup]
    @Binding var selectedGroup: TaskGroup?
    @Binding var appLanguage: String
    let isRegularWidth: Bool
    let addGroup: () -> Void

    var body: some View {
        List {
            ForEach(taskGroups) { group in
                Button {
                    selectedGroup = group
                } label: {
                    TaskGroupRow(group: group)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("ToDoTracker")
        .listStyle(.sidebar)
        .navigationSplitViewColumnWidth(
            min: 220,
            ideal: isRegularWidth ? 300 : 240,
            max: 360
        )
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                LanguageMenu(selection: $appLanguage)
            }

            ToolbarItem(placement: .topBarTrailing) {
                AddGroupButton(isRegularWidth: isRegularWidth, action: addGroup)
            }
        }
    }
}

private struct SelectedTaskGroupDetail: View {
    @Binding var taskGroups: [TaskGroup]
    let selectedGroup: TaskGroup?

    var body: some View {
        if let group = selectedGroup,
           let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
            TaskDetailView(group: $taskGroups[index])
        } else {
            ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
        }
    }
}

private struct TaskGroupRow: View {
    let group: TaskGroup

    var body: some View {
        Label {
            Text(verbatim: group.title)
        } icon: {
            Image(systemName: group.symbolName)
        }
    }
}

private struct LanguageMenu: View {
    @Binding var selection: String

    var body: some View {
        Menu {
            Picker("Language", selection: $selection) {
                ForEach(AppLanguage.allCases) { language in
                    Text(language.title).tag(language.rawValue)
                }
            }
        } label: {
            Label("Language", systemImage: "globe")
        }
        .accessibilityLabel("Language")
    }
}

private struct AddGroupButton: View {
    let isRegularWidth: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            if isRegularWidth {
                Label("Add Group", systemImage: "plus")
            } else {
                Image(systemName: "plus")
            }
        }
        .accessibilityLabel("Add Group")
    }
}
