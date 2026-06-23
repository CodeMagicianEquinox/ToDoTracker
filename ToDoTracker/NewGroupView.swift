//
//  NewGroupView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/22/26.
//
import SwiftUI

struct NewGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedIcon = "house.fill"
    let icons = ["house.fill", "heart.fill", "book.fill", "star.fill"]
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                //SECTION 1: Name
                Section("Group Name") {
                    TextField("E.g. Work, School ...", text: $groupName)
                }
                //SECTION 2: Icon Picker
                Section("Select Icon") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                        ForEach(icons, id: \.self) { icon in
                            Button {
                                selectedIcon = icon
                            } label: {
                                Image(systemName: icon)
                                    .frame(width: 44, height: 44)
                                    .background(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.clear)
                                    .foregroundStyle(selectedIcon == icon ? .blue : .gray)
                                    .clipShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(
                                selectedIcon == icon
                                    ? String(localized: "Selected icon")
                                    : String(localized: "Select icon")
                            )
                            .accessibilityValue(icon)
                        }
                    }
                }
                
            }
            .navigationTitle(Text("New Group"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let title = groupName.trimmingCharacters(in: .whitespacesAndNewlines)
                        let newGroup = TaskGroup(title: title, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .disabled(groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
