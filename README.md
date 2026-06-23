# ToDoTracker

ToDoTracker is a SwiftUI task-management app designed specifically for iPadOS. It demonstrates an adaptive sidebar-and-detail interface, iPad multitasking support, orientation-aware layout, accessibility, and English/Spanish localization.

## Assignment requirements

- **iPadOS target:** The app target supports iPad only.
- **Larger-screen interface:** `NavigationSplitView` presents task groups in a sidebar and the selected group's tasks in a detail column.
- **Multitasking:** The app does not require full screen and supports every iPad orientation, allowing it to resize for Split View and Slide Over.
- **Responsive layout:** SwiftUI's adaptive layout system and the horizontal size class adjust the sidebar width and toolbar content. The icon picker uses an adaptive grid.
- **Portrait and landscape:** All four iPad orientations are enabled.
- **Localization:** A String Catalog contains English source strings and Spanish translations, including the sample content.
- **Accessibility:** Icon actions use standard buttons, 44-point targets, and localized VoiceOver labels.

## App features

- Browse task groups in an iPad-style sidebar.
- Add a group and choose its SF Symbol.
- Add, edit, complete, and delete tasks.
- Automatically adapt between regular and compact window widths.

## Demonstration checklist

1. Run the app on an iPad simulator.
2. Rotate between portrait and landscape.
3. Select **School** or **Home** to show the sidebar/detail layout.
4. Resize the app or use iPad multitasking to demonstrate compact-width adaptation.
5. Add a group with the toolbar button, then add and complete a task.
6. In **Product > Scheme > Edit Scheme > Run > Options**, set **App Language** to Spanish and relaunch to demonstrate localization.

## Build

Open `ToDoTracker.xcodeproj` in Xcode, select an iPad simulator, and run the `ToDoTracker` scheme.
