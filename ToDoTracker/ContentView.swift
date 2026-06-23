//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//

import SwiftUI

struct ContentView: View {
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
            .toolbar{
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
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
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup // auto nav to the group selected
            }
        }
        
    }
}
