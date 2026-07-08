# ToDoTracker Localization Report

Class transcript notes:

The class discussion emphasized that language switching may not appear per-app in Settings on every Simulator/device setup, and that this assignment extends localization beyond text into image assets and locale-aware formatting. To make the work easy to demonstrate, ToDoTracker includes an in-app globe menu for System Default, English, Spanish, and French.

Task 1: localized strings

User-facing strings are managed in `ToDoTracker/Localizable.xcstrings` for English, Spanish, and French. This includes navigation labels, buttons, form labels, task placeholders, accessibility labels, default group names, default task names, the added description text, and the added call-to-action button. SwiftUI literals and `String(localized:)` load these values dynamically from the active locale.

Task 2: localized images/resources

The asset catalog now includes three language-specific banner image sets:

- `locale-banner-en`
- `locale-banner-es`
- `locale-banner-fr`

`TaskDetailView` displays the correct banner by reading the selected `AppLanguage` and loading that language's asset name. System Default falls back to the device locale and chooses English, Spanish, or French where available.

Task 3: locale-specific formats

`TaskDetailView` now shows a locale panel with:

- a full formatted date using `DateFormatter`
- the current time using `DateFormatter`
- an example decimal number using `NumberFormatter`

Each formatter receives the active `Locale`, so switching the in-app language changes date, time, and number formatting for English, Spanish, and French.

Verification:

`xcodebuild -scheme ToDoTracker -project ToDoTracker.xcodeproj -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build` succeeds. A Simulator-targeted build was also attempted, but the local CoreSimulator service reported that `simdiskimaged` was not responding, so the generic iOS build was used for verification.

## Assignment 3 RTL Update

Class transcript notes:

The Assignment 3 recording says the ToDoTracker app should add a right-to-left language such as Arabic or Hebrew, confirm that the whole interface flips correctly, fix any clipped long titles, and review iconography, typography, and cultural styling. The written assignment also asks for RTL layout support, cultural UI customization, and a locale-specific visual theme or asset catalog resource.

Task 1: right-to-left layouts

Arabic is now available in the in-app language menu. `ToDoTrackerApp` applies both the selected `Locale` and the selected `LayoutDirection`, so choosing Arabic changes the app to right-to-left without requiring the user to change the whole simulator/device language. The app continues to use semantic `leading` and `trailing` alignment, so the sidebar, labels, text fields, buttons, dividers, and toolbar items mirror naturally.

Task 2: cultural customization

The add-group sheet uses semantic cancellation and confirmation toolbar placements, so Cancel and Save appear in the correct platform order for both LTR and RTL layouts. Text fields use leading text alignment, which becomes right alignment in Arabic. The task rows and progress panel now inherit locale-aware accent colors, and the interface avoids fixed left/right positioning so labels and controls can mirror.

Task 3: locale-specific theme and assets

The app now includes an Arabic-specific asset catalog image set:

- `locale-banner-ar`

Arabic uses a green and gold regional theme, an Arabic banner, Arabic sample task/group names, Arabic strings for all existing user-facing copy, Arabic date/time/number formatting through `ar_SA`, and RTL layout direction. Existing English, Spanish, and French locale assets and formatting still work.

Verification:

`xcodebuild -scheme ToDoTracker -project ToDoTracker.xcodeproj -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build` succeeds after the Arabic RTL changes.
