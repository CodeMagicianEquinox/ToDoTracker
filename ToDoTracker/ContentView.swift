//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var taskGroups = TaskGroup.sampleData
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
    @State private var isShowingAddGroup = false
    
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
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup // auto nav to the group selected
            }
        }
        
    }
}
