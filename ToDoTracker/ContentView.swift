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
            
            // COLUMN 1: SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("ToDoTracker")
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(
                min: 220,
                ideal: horizontalSizeClass == .regular ? 300 : 240,
                max: 360
            )
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    if horizontalSizeClass == .regular {
                        Label("Add Group", systemImage: "plus")
                    } else {
                        Image(systemName: "plus")
                    }
                }
                .accessibilityLabel("Add Group")
            }
        } detail: {
            // COLUMN 2: DETAILS (selected group)
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskDetailView(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
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

        let groups = TaskGroup.sampleData
        taskGroups = groups
        selectedGroup = groups.first
    }
}
